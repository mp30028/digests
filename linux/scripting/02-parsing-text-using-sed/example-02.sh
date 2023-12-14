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
echo "--------------------- Simple output of message ----------------------------";
echo "1. echo \"\${message}\";"
echo 
echo "${message}";
echo "===========================================================================";
echo

#json=$(echo ${message} | sed "s/.*---//;s/===.*//");

echo
echo "----- Capitalise all occurences of the word 'module' in message Ex.1 -------";
echo "Note in line 1 \${message} is not in quotes. So sed strips the newlines out"
echo "Also only the first occurrence of the word 'module' is replaced"
echo "1. changed_message=$(echo \${message} \| sed \"s/module/MODULE/\");"
echo "2. echo \"\${changed_message}\";";
echo 
echo "~~~~~~~~~~~~~~~~~~~~~ NOTES ~~~~~~~~~~~~~~~~~~~"
echo "s   Substitute command"
echo "/../../   Delimiter"
echo ".*---//   Regular Expression pattern to be searched"
echo "night   Replacement string"
echo "###############################################"
echo 
changed_message=$(echo ${message} | sed "s/module/MODULE/");
echo "${changed_message}";
echo "============================================================================";
echo



echo
echo "----- Capitalise all occurences of the word 'module' in message. Ex.2 -------";
echo "This time in line 1 \${message} is in quotes. So the newlines are not stripped out"
echo "1. changed_message=$(echo \"\${message}\" \| sed \"s/module/MODULE/\");"
echo "2. echo \"\${changed_message}\";";
echo 
echo 
changed_message=$(echo "${message}" | sed "s/module/MODULE/");
echo "${changed_message}";
echo "============================================================================";
echo


echo
echo "----- Capitalise all occurences of the word 'module' in message. Ex.2 -------";
echo "This time in line 1 \${message} is in quotes. So the newlines are not stripped out"
echo "1. changed_message=$(echo \"\${message}\" \| sed \"s/module/MODULE/\");"
echo "2. echo \"\${changed_message}\";";
echo 
echo 
changed_message=$(echo "${message}" | sed "s/module/MODULE/");
echo "${changed_message}";
echo "============================================================================";


echo
echo "----- Extract json from message and replace the delimiters. Ex.3 -------";
echo "1. changed_message=$(echo \"\${message}\" \| sed 's/.*---/+++/;s/===.*/+++/');"
echo "2. echo \"\${changed_message}\";";
echo 
echo 
changed_message=$(echo ${message} | sed 's/.*---/+++/;s/===.*/+++/');
echo "${changed_message}";
echo "============================================================================";