#!/bin/bash
# use this script to create biolerplates using bash

# SCAFFI
# by: Paweł Witek
# license: MIT


# how to use:

# scaffi -t="https://github.com/wolfiesites/scaffi-example-template" --filename="amazing filename" --name="wolf with wolfies" --directory="awesome dir" --dirtwo="awesome dir two"
# scaffi -t="https://github.com/wolfiesites/scaffi-example-template" -s="all placeholders one name"

# passed flags are dynamically generated based on provided template!

# name placehodlers  like: #{{variable}} or #{{variableCC}} or #{{variablePC}} or #{{variableSC}} or #{{variableKC}} #{{variableSPACE}}
# placeholders can be used on directory/file/withinfile

# HOW TO INSTALL:
# sudo touch /usr/bin/scaffi
# Paste this script to /usr/bin/scaffi
# sudo chmod +x /usr/bin/scaffi

# Create ur templates like this:
# https://github.com/wolfiesites/scaffi-example-template

# you can store it in computer or in github

# types of cases to format variables sent:
# KC kebab  case: hello-its-me					// name that registering scripts and block-types-registration
# SC snake  case: hello_its_me          			// name that function in php
# CC camel  case: helloItsMe  					// name that variables
# PC pascal case: HelloItsMe 					// name that classes

## Enjoy! :)

input="$*"
allParams="$@"
# for node:
IFS=',' read -ra allParams <<< "$allParams"


arrayOfVariables=()
counter=0
declare -A varPLACEHOLDERS

function createAllCasesPlaceholder() {
	local my
	local myCases
	myCases=()
	my=$1
	myCases=("#{{$my}}" "#{{$my""SC}}" "#{{$my""KC}}" "#{{$my""PC}}" "#{{$my""CC}}" "#{{$my""SPACE}}" )
	declare -a varPLACEHOLDER=${myCases[@]}
	varPLACEHOLDERS[$counter]=${varPLACEHOLDER[@]}
	((counter=counter+1))
}
function createAllCasesPlaceholderFile() {
	local my
	local myCases
	myCases=()
	my=$1
	myCases=("{$my}" "{$my""SC}" "{$my""KC}" "{$my""PC}" "{$my""CC}" "{$my""SPACE}" )
	export declare filnamePLACEHOLDERS=(${myCases[@]})
}

function toSpaceName() {
	echo $* | sed -E 's|-| |g' | sed -E 's|_| |g' | tr "[:upper:]" "[:lower:]"
}
function toCamelCase() {
	echo $* | sed -E 's/(-|_| )([a-z])/\U\2/g' | sed -E 's|^.|\L&|'
}
function toSnakeCase() {
	echo $* | sed -E 's|-|_|g' | sed -E 's| |_|g' | tr '[:upper:]' '[:lower:]'
}
function toKebabCase() {
	echo $* | sed -E 's|_|-|g' | sed -E 's| |-|g' | tr '[:upper:]' '[:lower:]'
}
function toPascalCase() {
	echo $* | sed -E 's/(-|_| )(.)/\U\2/g' | sed -E 's|_||g' | sed -E 's| ||g' | sed -E 's|-||g' | sed -E 's|^.|\U&|'
}
function createAllCasesVar() {
	local xxxinput
	local xxxname
	xxxinput=$2
	xxxname=$1
	if [[ -z $1 ]]; then
		echo 'variable needs a name: $1' 
		echo 'I need value to be passed: $2'
		return
	fi
	if [[ -z $2 ]]; then
		echo 'I need value to be passed: $2'
		return
	fi
	export declare $xxxname="$xxxinput";
	export declare $xxxname"KC"=$(toKebabCase "$xxxinput");
	export declare $xxxname"SC"=$(toSnakeCase "$xxxinput");
	export declare $xxxname"CC"=$(toCamelCase "$xxxinput");
	export declare $xxxname"PC"=$(toPascalCase "$xxxinput");
	export declare $xxxname"SPACE"=$(toSpaceName "$xxxinput");
}

function scanForPlaceholdersInFileNames(){
	files=($(find . -regex ".*/#{{.*}}.*"))
	echo $files
	for fileWithPath in "${files[@]}"
	do
	    placeholder=$(echo $fileWithPath | sed -E 's|.*\#\{\{(.*)\}\}.*|\1|g' | sed -E 's/PC|SPACE|SC|KC|CC//g')
	    arrayOfVariables+=($placeholder)
	done
}

function scanForPlaceholdersInFiles() {
	placeholders=($(grep --exclude-dir="node_modules" -Roh '#{{.*}}' .))
	for placeholder in "${placeholders[@]}"
	do
	    placeholderRdy=$(echo $placeholder  | sed -E 's/PC|CC|SC|KC|SPACE//g' | sed -E 's/#\{\{|\}\}//g' )
	    arrayOfVariables+=($placeholderRdy)
	done
}


template=''

# set template option
for p in "${allParams[@]}"
do
    case $p in
    	-h|--help)
			GREEN='\033[0;32m'
			RED='\033[0;31m'
			BLUE='\033[0;36m'
			YELLOW='\033[0;33m'
			NC='\033[0m' # No Color
          	echo '                __  __ _ '
          	echo '               / _|/ _(_)'
          	echo ' ___  ___ __ _| |_| |_ _ '
          	echo '/ __|/ __/ _` |  _|  _| |'
          	echo '\__ \ (_| (_| | | | | | |'
          	echo '|___/\___\__,_|_| |_| |_|'
          	echo ''
          	echo ''
          	echo "The only scaffolding tool you will ever need!"
          	echo "by: 		Paweł Witek"
          	echo "LICENSE:	MIT"
          	echo ""
          	echo ""
          	echo -e "${RED}IMPORTANT: IT WORKS ON UNIX BASED (MAC / LINUX) SYSTEMS WITH BASH INSTALLED${NC}"
          	echo -e "${RED}IF YOU'RE on WINDOWS, Please consider installing${NC} ${GREEN}WSL${NC}"
          	echo ""
          	echo "scaffi dynamically creates flags based on the provided template!"
          	echo "Handles all kinds of cases:"
          	echo "* KC: 		kebab case"
          	echo "* SC: 		snake case"
          	echo "* CC: 		camel case" 
          	echo "* PC: 		pascal case" 
          	echo "* SPACE: 	text with space"
          	echo ""
          	echo ""
          	echo "--------------------"
          	echo "How to use:"
          	echo ""
          	echo -e "${YELLOW}scaffi --placholder=\"my awesome value\" --placeholder2=\"my amazing value two\" -t=\"/path/to/my/template\"${NC}"
          	echo "EXAMPLE:"
          	echo -e "${YELLOW}scaffi --directory=\"my awesome dir\" --dirtwo=\"my amazing dir two\" --filename=\"Scaffi is the best\" --name=\"custom variable\" -t=\"https://github.com/wolfiesites/scaffi-example-template\"${NC}"
          	echo ""
          	echo ""
          	echo 'than flags value --placeholder will be tansformed according to case which has been defined in the provided template like:'
          	echo ""
          	echo '#{{placeholder}} 		replaces to "my awesome value"'
          	echo '#{{placeholderKC}} 		replaces to "my-awesome-value"'
          	echo '#{{placeholderSC}} 		replaces to "my_awesome_value"'
          	echo '#{{placeholderCC}} 		replaces to "myAwesomeValue"'
          	echo '#{{placeholderPC}} 		replaces to "MyAwesomeValue"'
          	echo '#{{placeholderSPACE}}	 	replaces to "my awesome value"'
          	echo ""
          	echo -e "${RED}flags are being created based on provided template!${NC}"
          	echo -e "${RED}look at template example from the github: https://github.com/wolfiesites/scaffi-example-template${NC}"
          	echo "--------------------"
          	echo "options:"
          	echo ""
          	echo "-h, --help 		 shows this help"
          	echo "-d, --dry-run 		 scans template and displays all placeholders. IT DOES NOT OVERRIDE PLACEHOLDERS"
          	echo "-t, --template 		 provide a template. It can be a folder on your computer or github / gitlab repo"
          	echo "-s, --same-value 	 uses this variable to replace all placeholders with same value"
          	echo ""
          	echo ""
          	echo ""
          	echo "--------------------"
          	echo "future ideas/features:"
          	echo ""
          	echo "- interactive mode"
          	echo "- conditional placeholders for block of code"
          	echo "- file config feed"
          	echo "- private repo with token auth"
          	export declare help='help'
          	exit # this stops the loop
        ;;
        -t*|--template*)
			value=`echo $p | sed -E 's|.*=(.*)|\1|'`
			export declare template="$value" 			
		;;
    esac
done


# download template
if [[ ! -z $template ]]; then
	if [[ ! $template =~ https ]]; then
		templatename='xyz'
		templatename=$(echo ${template##*/})
		cp -R $template .
		cp -R $templatename/* .
		rm -rf $templatename
	fi
	if [[ $template =~ https ]]; then
		templatename='xyz'
		templatename=$(echo ${template##*/})
		git clone $template
		cp -R $templatename/* .
		rm -rf $templatename
		rm -rf .git
	fi
fi


scanForPlaceholdersInFiles
scanForPlaceholdersInFileNames

sorted_unique_placeholders=($(echo "${arrayOfVariables[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))


help=''
dryrun=''
template=''
samevalue=''


# define here dynamic variables from the array. by default set them empty
for i in "${sorted_unique_placeholders[@]}"
do
    export declare $i=''
done

if [[ -z $sorted_unique_placeholders ]]; then
	if [[ -z $template ]]; then
		echo ""
		echo 'template is required!'
		echo 'scaffi --template="/path/to/your/template"'
		echo 'OR'
		echo 'scaffi --template="https://github.com/wolfiesites/scaffi-example-template" -s="single val"'
		echo ""
		echo "for more help use:"
		echo "scaffi --help"
	fi
fi

for p in "${allParams[@]}"
do
    case $p in 
        -s*|--same-value*)
            value=`echo $p | sed -E 's|.*=(.*)|\1|'`
			export declare samevalue="$value"     
        ;;
        -d|--dry-run)
			export declare dryrun="dryrun"
			echo flags to provide, based on scanned template:
			for i in "${sorted_unique_placeholders[@]}"
			do
	    		echo "--$i"
			done
        ;;
        -t*|--template*)
			value=`echo $p | sed -E 's|.*=(.*)|\1|'`
			export declare template="$value"
        ;;
        *)
			# define dynamic flags from scanned placholders
            for myvar in "${sorted_unique_placeholders[@]}"
            do
            	case $p in
            		--$myvar*)
					value=`echo $p | sed -E 's|.*=(.*)|\1|'`
					export declare $myvar="$value"
            	esac
            done
        ;;
    esac
done


if [[ -z $samevalue ]]; then
	test=''
	for i in "${sorted_unique_placeholders[@]}"
	do
	    value=$(eval "echo \$$i")  
	    if [[ $value == '' ]]; then
	      echo "--$i option is needed"
	      test+=false
	    fi
	done
	if [[ $test =~ false ]]; then
		echo ""
		echo "or you can set one value for all the placeholders:"
		echo "--same-value=\"my awesome same value\""
		exit
	fi
fi



if [[ -z $samevalue ]]; then
	# define all placholedrs with each CASE
	for myVariable in "${sorted_unique_placeholders[@]}"
	do
		value=$(eval "echo \$$myVariable")
		createAllCasesVar "$myVariable" "$value"
	    createAllCasesPlaceholder "$myVariable"
	done
else
	for myVariable in "${sorted_unique_placeholders[@]}"
	do
		createAllCasesVar "$myVariable" "$samevalue"
	    createAllCasesPlaceholder "$myVariable"

	done
fi

# REPLACE ALL PLACHOLDERS BELOW
# rename directories
for placeholders in "${varPLACEHOLDERS[@]}"
do
	tmp=(${placeholders[@]})
	for s in "${tmp[@]}"
	do
	    directories=($(find . -type d -regex ".*#.*}}"))
	    if [[ ! -z $directories ]]; then
			for dirWithPath in "${directories[@]}"
			do
				replace=$(echo $s | sed -E 's|#\{\{||' | sed -E 's|\}\}||g' )
				replace=$(eval "echo \$$replace")
				ext=$(echo ${dirWithPath##*\.})
				dir=$(echo ${dirWithPath%\/*}/)
				shorthand=$(echo $s | sed -E 's/\{|#|\}//g')
				if [[ $dirWithPath =~ $shorthand ]]; then
					mv $dirWithPath $dir$replace &>/dev/null
				fi
			done
		fi
	done
done

# rename Files
for placeholders in "${varPLACEHOLDERS[@]}"
do
	tmp=(${placeholders[@]})
	for s in "${tmp[@]}"
	do
	    files=$(find . -type f     -regex ".*/$s.*")
	    if [[ ! -z $files ]]; then
			for fileWithPath in "${files[@]}"
			do
				replace=$(echo $s | sed -E 's|#\{\{||' | sed -E 's|\}\}||g' )
				replace=$(eval "echo \$$replace")
				ext=$(echo ${fileWithPath##*\.})
				dir=$(echo ${fileWithPath%\/*}/)
				shorthand=$(echo $s | sed -E 's/\{|#|\}//g')
				if [[ $fileWithPath =~ $shorthand ]]; then
					mv $fileWithPath $dir$replace.$ext &> /dev/null
				fi
			done
		fi
	done
done

# replace all placholders within a files with a values
for placeholders in "${varPLACEHOLDERS[@]}"
do
	tmp=(${placeholders[@]})
	for s in "${tmp[@]}"
	do
	    filesVarName=($(grep -Rl $s .))
	    if [[ ! -z $filesVarName ]]; then
		for file in "${filesVarName[@]}"
		do
			ext=$(echo ${file##*\.})
			dir=$(echo ${file%\/*}/)
			replace=$(echo $s | sed -E 's|#\{\{||' | sed -E 's|\}\}||g' )
			replace=$(eval "echo \$$replace")
				if [[ $s =~ KC ]]; then
						perl -i -pe "s|$s|$replace|" $file
				fi
				if [[ $s =~ CC ]]; then
						perl -i -pe "s|$s|$replace|" $file
				fi
				if [[ $s =~ SC ]]; then
						perl -i -pe "s|$s|$replace|" $file
				fi
				if [[ $s =~ PC ]]; then
						perl -i -pe "s|$s|$replace|" $file
				fi
				if [[ $s =~ SPACE ]]; then
						perl -i -pe "s|$s|$replace|" $file
				fi
				if [[ ! $s =~ C  ]]; then
						perl -i -pe "s|$s|$replace|" $file
				fi		
			done
		fi
	done
done
