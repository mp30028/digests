#!/bin/bash


echo "---- Understanding \">/dev/null 2>&1\" (suppressing output) ----"
echo "\">/dev/null 2>&1\" redirects (>&) stderr (2 - containing error messages from" 
echo "the executed command or script) to stdout (1 - the output of the command) "
echo "which in turn is redirected to /dev/null (the null device), and so suppresses"
echo "all messages that might be issued by the executed command."
echo 
echo "/dev/null is a standard file that discards all you write to it, but reports"
echo "that the write operation succeeded."
echo 
echo "Whenever you execute a program, the operating system always opens three files:-"
echo "        standard input," 
echo "        standard output, and" 
echo "        standard error." 
echo "Whenever a file is opened the operating system (kernel) returns a non-negative "
echo "integer called a file descriptor."
echo "The file descriptors for these three files are 0, 1, and 2, respectively."
echo 
echo "Thus 2>&1 redirects standard error to standard output. The & indicates that the"
echo "value following is a file descriptor, and the value 1 is the standard output"
echo "if you use just 1 without the &  standard error output will be redirected to a "
echo "file named 1."
echo " In summary [any command] >>/dev/null 2>&1 redirects all standard error to "
echo "standard output, and writes all of that to /dev/null."
echo "============================================================================";
echo
echo 
echo 
echo "---- Checking the status of an executed command, especially when we have suppressed output ----" 
echo "To check the exit status of the previous command inspect the \$? variable."
echo "For example we can see the result of executing \"grep localhost /etc/hosts > /dev/null 2>&1\""
echo "by referencing \$?"
echo 
echo "1. grep localhost /etc/hosts > /dev/null 2>&1"
echo "2. echo \"after executing \\\"grep localhost /etc/hosts > /dev/null 2>&1\\\", dollar-question-mark = \$?\" ";
echo 
echo 
grep localhost /etc/hosts > /dev/null 2>&1
echo "after executing \"grep localhost /etc/hosts > /dev/null 2>&1\", dollar-question-mark = $?" 
echo 
echo "============================================================================";
echo
echo 
echo 
echo "---- Checking the status of one of the executed commands in a chain of piped commands ----" 
echo "The \$? variable reports on the status of the last executed command. However if we have "
echo "a chain of piped commands and we want to know the status of one of those commands, then things"
echo "can start to look a bit complicated if try to use \$? (\$? will in fact report the status of "
echo "the last command in the chain)." 
echo "For example executing \"grep localhost /etc/hosts > /dev/null 2>&1\" | tee /tmp/results.txt"
echo "by referencing \$? will return the status of tee and not the grep."
echo 
echo "1. grep localhost /etc/hosts > /dev/null 2>&1 | tee /tmp/results.txt"
echo "2. tmp_var=\"\${PIPESTATUS[0]}\" #store PIPESTATUS[0] into tmp_var ";
echo "3. echo \"after executing \\\"grep localhost /etc/hosts > /dev/null 2>&1 | tee /tmp/results.txt\\\"\""
echo "4. echo \"\\\${PIPESTATUS[0]} (i.e. the status of the grep) = \${tmp_var}\""
echo 
echo 
grep localhost /etc/hosts > /dev/null 2>&1 | tee /tmp/results.txt
tmp_var="${PIPESTATUS[0]}" #store PIPESTATUS[0] into tmp_var
echo "after executing \"grep localhost /etc/hosts > /dev/null 2>&1 | tee /tmp/results.txt\""
echo "\${PIPESTATUS[0]} (i.e. the status of the grep) = ${tmp_var}"
echo 
grep non-existent-value /etc/hosts > /dev/null 2>&1 | tee /tmp/results.txt
tmp_var="${PIPESTATUS[0]}"
echo "after executing \"grep non-existent-value /etc/hosts > /dev/null 2>&1 | tee /tmp/results.txt\""
echo "\${PIPESTATUS[0]} (i.e. the status of the grep) = ${tmp_var}"
echo 
echo "============================================================================";






#echo 
#echo 
#echo "----- Validate the json from previous exercise using jq. Ex.2 -------";
#echo "1. json=$(echo \"\${message}\" \| sed 's/.*---//;s/===.*//');"
#echo "2. echo \"\${json}\";";
#echo "¯\(ツ)/¯     ~()~"
#echo 
#validation_result=$(echo $json | jq -e . >/dev/null 2>&1  ; echo ${PIPESTATUS[1]})
#echo "validation_result = ${validation_result}";
#echo "============================================================================";