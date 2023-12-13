#!/bin/bash

	expected='Merge pull request #126 from mp30028/continue_developing_pipelines
	updated version.txt to trigger workflows at 12:13 10/12/2023
	---
		{"versioning": 
		  [
		    {"module": "API", "release": "MAJOR"},
		    {"module": "UI","release": "PATCH"}
		  ]
		}
	==='

function compare_messages(){
	caller_name=$1;
	expected=$2;
	actual=$3;
	# using process substitution `<()` 
	result=$(diff <( echo "$expected" ) <( echo "$actual" ));	
	if [[ $result != "" ]]; then
	    echo "FROM \"${caller_name}\" FAILED: expected and actual are different";
	    echo
	    echo
	    echo "$result";
	    echo
	    echo
	else
	    echo "FROM \"${caller_name}\" OK: expected and actual match";
	fi
}

function test_get_message_with_no_arguments(){
	source ./example-01.sh &>/dev/null;
	actual=$(get_message);
	compare_messages "test_get_message_with_no_arguments" "${expected}" "${actual}";
	#actual=$(./example-01.sh)
}

function test_get_message_with_arguments(){
	source ./example-01.sh &>/dev/null;
	actual=$(get_message "${expected}");
	compare_messages "test_get_message_with_arguments" "${expected}" "${actual}";
}

function test_example_01_script(){
	actual=$(source ./example-01.sh);
	compare_messages "test_example_01_script" "${expected}" "${actual}";
}

test_get_message_with_no_arguments;
test_get_message_with_arguments;
test_example_01_script;


