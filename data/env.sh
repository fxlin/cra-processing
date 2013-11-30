#########################################################
#
# to use:  
# source ./env.sh
# 
# output to /tmp/job/
#
# to run the keyword list over all files. 
# search_multi_keywords 
#
# to run a single keyword, do 
# search_keyword_savefile $keyword
#########################################################

# arg1: filename
# will print school name to stdout
get_school()
{
	keyword="Organization/Institution:"
	if grep -q $keyword $1; then
		cat $1 | grep $keyword | awk -F':' '{print $2}'
	else
		echo "error: school name no found in ", $1
	fi	
}

# arg1: filename
# will print dept name to stdout
get_dept()
{
	keyword="Department:"
	if grep -q $keyword $1; then
		cat $1 | grep $keyword | awk -F':' '{print $2}'
	else
		echo "dept=??"
	fi	
}

univ=0

# arg1: filename 
# arg2: keyword
search_onefile()
{
	#echo "search $2 in file $1..."
	if grep -q -i "$2" $1; then
		let "univ += 1"
		school=`get_school $1`
		dept=`get_dept $1`
		echo "============================================="
		echo $school ---- $dept
		echo $1
		echo "============================================="		
		grep "$2" $1 -C1 -i  #-C: show context lines   -i: case insensitive
		echo 
	#else
		#echo "no found"		
	fi
}

# arg1: keyword
search_keyword()
{
	#echo "search $1...."
	# build file name
	allfiles=`find .  -name "*.txt" -exec ls {}  \;`
	for f in $allfiles
	do
		search_onefile $f "$1"
	done
}

export MYOUTDIR="/tmp/job/"

# arg1: keyword
search_keyword_savefile()
{
	filename=`echo $1 | sed s/\ /+/g`
	
	search_keyword "$1" > $MYOUTDIR/$filename
	echo "$1 $univ" >> $MYOUTDIR/summary.txt
}

keywords="mobile
distributed system
architecture
software system
machine learning
big data
operating system
runtime
parallel computing
compiler
virtualization
health
cyber-phys
security
theory
computer vision
cloud
network
"

search_multi_keywords()
{	
	rm -rf $MYOUTDIR/*
	mkdir -p $MYOUTDIR
	
	saved=$IFS
	IFS=$(echo -en "\n\b")

	for k in $keywords
	do
		univ=0
		echo "search $k ..."
		search_keyword_savefile $k
	done
	IFS=$saved
}

