#!/bin/bash

default_start_delimiter="---";
default_end_delimiter="===";
default_release_type="PATCH";
default_message="This is a default test message";

function get_message(){
	input_value=$1;
	message=${input_value:=${default_message}};
	echo "${message}";
}


function extract_json(){
	message=$1;
	in_start_delimiter=$2;
	in_end_delimiter=$3;
	start_delimiter=${in_start_delimiter:=${default_start_delimiter}};
	end_delimiter=${in_end_delimiter:=${default_end_delimiter}};
	json=$(echo ${message} | sed "s/.*${start_delimiter}//;s/${in_end_delimiter}.*//");
	echo "$json";
}

function validate_json(){
	json=$1;
	validation_result=$(echo $json | jq -e . >/dev/null 2>&1  ; echo ${PIPESTATUS[1]});
	if [[ $validation_result == 0 ]]; then
		echo true;
	else
		echo false;
	fi;	
}

function get_release_type_from_json(){
	json=$1;
	module_id=$2;
	release_type="$(echo "${json}" | jq -r ".versioning[] | select(.module == \"${module_id}\") | .release")";
	echo "${release_type}";
}

function validate_release_type(){
	release_type=$1;
    if [[ "${release_type}" == "PATCH" ]] || [[ "${release_type}" == "MINOR" ]] || [[ "${release_type}" == "MAJOR" ]]; then
      is_valid=true;
    else
      is_valid=false;
    fi;
    echo ${is_valid};
}

function get_validated_release_type(){
	value=$1;
	is_value_valid=$(validate_release_type "${value}");
    if [[ ${is_value_valid} == true ]]; then 
      validated_value="${value}";
    else
      validated_value="PATCH";
    fi;
    echo "${validated_value}";
}

function main(){
	message="$(get_message "${input_message}")";
	extracted_json="$(extract_json "${message}")";
	is_extracted_json_valid="$(validate_json "${extracted_json}")";
	if [[ $is_extracted_json_valid == true ]]; then
	  release_type_from_json="$(get_release_type_from_json "${extracted_json}" "${input_module_id}")";
	else
	  release_type_from_json="$default_release_type";
	fi;
	validated_release_type="$(get_validated_release_type "${release_type_from_json}")";
    echo "${validated_release_type}";
}

input_module_id=$1;
input_message=$2;
echo "$(main)";
   
#input_message='${{ steps.head_commit_message.outputs.value }}';
#input_module_id="${{ inputs.module_id }}";
#release_type="$(main)";
#echo "value=$release_type" >> $GITHUB_OUTPUT;
