#!/bin/bash

message="Merge pull request #126 from mp30028/continue_developing_pipelines
	updated version.txt to trigger workflows at 12:13 10/12/2023
	---
		{\"versioning\": 
		  [
		    {\"module\": \"API\", \"release\": \"MAJOR\"},
		    {\"module\": \"UI\",\"release\": \"PATCH\"}
		  ]
		}
	===
";



echo
echo "----- Extract json from message using sed. Ex.1 -------";
echo "1. json=\$(echo \${message} | sed 's/.*---//;s/===.*//');"
echo "2. echo \"\${json}\";";
echo 
echo 
json=$(echo ${message} | sed 's/.*---//;s/===.*//');
echo "${json}";
echo "============================================================================";




echo
echo "----- Building on the previous step, filter the extracted json through jq. Ex.2 -------";
echo "jq filters the JSON stream. The input is parsed as a sequence of whitespace-separated";
echo "JSON values passed through the filter one at a time. The output(s) of the filter are"
echo "written to standard output, as a sequence of newline-separated JSON data."

echo "The shell's quoting rules means it is necessary to quote the input to jq using"
echo "single-quote characters. Else the shell fails as it will try to execute the input and"
echo "return  .... is not defined."
echo "Which is why the expression  echo \${message}   in the previous step is changed and"
echo "surrounded by escaped single quotes   echo \\'\${message}\\'"
echo 
echo "1. filtered_json=\$(echo \\'\${message}\\' | sed 's/.*---//;s/===.*//' | jq '.');"
echo "2. echo \"\${filtered_json}\";";
echo 
echo 
filtered_json=$(echo \'${message}\' | sed 's/.*---//;s/===.*//' | jq '.');
echo "${filtered_json}";
echo "============================================================================";




echo 
echo 
echo "----- Validate the json from previous exercise using jq. Ex.2 -------";
echo 
echo "The -e (or --exit-status) option of jq sets the exit status to "
echo "      0 if the last output values was neither false nor null"
echo "      1 if the last output value was either false or null"
echo "      4 if no valid result was ever produced"
echo "Normally jq exits with "
echo "      2 if there was any usage problem or system error"
echo "      3 if there was a jq program compile error"
echo "      0 if the jq program ran."
echo 
echo 
echo "1. validation_result=\$(echo \$json | jq -e . >/dev/null 2>&1  ; echo \${PIPESTATUS[1]})"
echo "2. echo \"validation_result = \${validation_result}\";";
echo 
echo 
validation_result=$(echo $json | jq -e . >/dev/null 2>&1  ; echo ${PIPESTATUS[1]})
echo "validation_result = ${validation_result}";
echo "============================================================================";



echo "--- Parse the json and read a value ---"

release_type=$(echo $json | jq -r '.versioning[] | select(.module == "API") | .release');
echo "release_type = ${release_type}";

echo "-- Check the parsed value has a valid allowed (PATCH, MINOR or MAJOR) value ---"
        if [[ "${release_type}" == "PATCH" ]] || [[ "${release_type}" == "MINOR" ]] || [[ "${release_type}" == "MAJOR" ]]; then
          echo "release field in json has a valid value. Everything looks good";
          is_valid_release_type=true
        else
          echo "release field in json does not have an expected value";
          is_valid_release_type=false;
        fi;
echo "is_valid_release_type = ${is_valid_release_type}";