#!/bin/bash

module_id=$1;
input_message=$2;
default_message="Merge pull request #126 from mp30028/continue_developing_pipelines
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

function get_message(){
	input_value=$1;
	message=${input_value:=${default_message}};
	echo "${message}";
}

get_message;

