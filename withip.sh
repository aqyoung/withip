#!/bin/bash
# all_num=10
# The author of this tool is @aqyoung,contact details:"yang2021@foxmail.com".
# You can change "thread_num" to modify the number of threads, it depends on your network and cpu
thread_num=10
logo(){
echo -e "\033[0;31m
 .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| | _____  _____ | || |     _____    | || |  _________   | || |  ____  ____  | || |     _____    | || |   ______     | |
| ||_   _||_   _|| || |    |_   _|   | || | |  _   _  |  | || | |_   ||   _| | || |    |_   _|   | || |  |_   __ \   | |
| |  | | /\ | |  | || |      | |     | || | |_/ | | \_|  | || |   | |__| |   | || |      | |     | || |    | |__) |  | |
| |  | |/  \| |  | || |      | |     | || |     | |      | || |   |  __  |   | || |      | |     | || |    |  ___/   | |
| |  |   /\   |  | || |     _| |_    | || |    _| |_     | || |  _| |  | |_  | || |     _| |_    | || |   _| |_      | |
| |  |__/  \__|  | || |    |_____|   | || |   |_____|    | || | |____||____| | || |    |_____|   | || |  |_____|     | |
| |              | || |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
\033[0m            "
}
aizhan(){
int=1
echo Enter the number of pages you want to crawl , only integers
read pages
while(( $int<=$pages ))
do
        echo -e "\033[1;32m Running page "$int" crawl.................. \033[0m"
        echo .......... | xargs -n 1 -I {} -P ${thread_num} sh -c "curl  https://dns.aizhan.com/$1/$int/ >>./$1.temp.txt"
        let int++
done
	cat ./$1.temp.txt | grep -Eo "(blank\">.{5,100}</a>)+" |awk -F '>' '{print $2}'|awk -F '<' '{print $1}' | sort -u > ./$1.aizhan.txt
        rm -rf ./$1.temp.txt
        echo  -e "\033[1;32m-----------------------Request completed ---------------------------\033[0m"
        cat  ./$1.aizhan.txt
        echo You searched a total of "$pages" pages
        echo The number of domain names on the same IP as the current website is:"$(cat ./$1.aizhan.txt |wc -l)"
	echo -e "\033[1;33mThe text file has been generated in the current directory, 
and the file name is:\"$1.aizhan.txt\"\033[0m"
        echo  -e "\033[1;32m--------------------------------------------------------------------\033[0m"
}
logo
aizhan $1
