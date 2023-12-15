#!/bin/bash

valid_msg="This is a valid test message held in a local variable
	It was created on 08:53 15/12/2023 in a test script called test-example-05
	---
		{\"versioning\": 
		  [
		    {\"module\": \"FIRST-MODULE\", \"release\": \"MAJOR\"},
		    {\"module\": \"SECOND-MODULE\",\"release\": \"PATCH\"}
		  ]
		}
	===
";


invalid_msg="This is an invalid test message held in a local variable
	It is invalid because it is missing the delimiters that mark out the json
	It was created on 08:53 15/12/2023 in a test script called test-example-05
	
		{\"versioning\": 
		  [
		    {\"module\": \"FIRST-MODULE\", \"release\": \"MAJOR\"},
		    {\"module\": \"SECOND-MODULE\",\"release\": \"PATCH\"}
		  ]
		}
";

invalid_json_msg="This is a test message held in a local variable but the json it holds is not properly formed 
	It was created on 08:53 15/12/2023 in a test script called test-example-05
	---
		{\"versioning\": 
		  [
		    {module: \"FIRST-MODULE\", \"release\": \"MAJOR\"},
		    {\"module\": \"SECOND-MODULE\",\"release\": \"PATCH\"}
		  ]
		}
	===
";

invalid_value_msg="This is a test message held in a local variable
	The message and the embedded json are all correct. However the values 
	assigned for the release fields are not one of the acceptable values
	It was created on 08:53 15/12/2023 in a test script called test-example-05
	---
		{\"versioning\": 
		  [
		    {\"module\": \"FIRST-MODULE\", \"release\": \"OTHER\"},
		    {\"module\": \"SECOND-MODULE\",\"release\": \"NONE\"}
		  ]
		}
	===
";



function compare_values(){
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

function test_with_valid_msg(){
	expected="MAJOR";
	actual="$(source ./example-05.sh "FIRST-MODULE" "$valid_msg")";
	compare_values "test_with_valid_msg" "${expected}" "${actual}";
}

function test_with_invalid_msg(){
	expected="PATCH";
	actual="$(source ./example-05.sh "FIRST-MODULE" "$invalid_msg" 2>/dev/null)";
	compare_values "test_with_invalid_msg" "${expected}" "${actual}";
}

function test_with_invalid_json_msg(){
	expected="PATCH";
	actual="$(source ./example-05.sh "FIRST-MODULE" "$invalid_json_msg" 2>/dev/null)";
	compare_values "test_with_invalid_json_msg" "${expected}" "${actual}";
}

function test_with_invalid_value_msg(){
	expected="PATCH";
	actual="$(source ./example-05.sh "FIRST-MODULE" "$invalid_value_msg")";
	compare_values "test_with_invalid_value_msg" "${expected}" "${actual}";
}


#function test_get_message_with_arguments(){
#	source ./example-01.sh &>/dev/null;
#	actual=$(get_message "${expected}");
#	compare_messages "test_get_message_with_arguments" "${expected}" "${actual}";
#}
#
#function test_example_01_script(){
#	actual=$(source ./example-01.sh);
#	compare_messages "test_example_01_script" "${expected}" "${actual}";
#}
#
#test_get_message_with_no_arguments;
#test_get_message_with_arguments;
#test_example_01_script;

test_with_valid_msg
test_with_invalid_msg
test_with_invalid_json_msg
test_with_invalid_value_msg