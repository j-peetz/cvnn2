# This scrips add all changes to git updating the version of the changed files by one. And then commits using the message as the second parameter.
# Usage: ./auto-version-commit.sh "My commit message"

if [ "$1" != '' ]; then
IFS="
"
git status -s
for p in `git status -s`	# For each file in git status
do
	file=`echo "$p" | cut -d ' ' -f2`			# Take the name of the file
	if [ "$file" != "auto-version-commit.sh" ]; then	# Ignores himself
		if grep -q __version__ $file; then		# Check version is in the file
			echo "Increasing version of file $file"
			oldver=`grep __version__ $file`
			vernum=`echo $oldver | cut -d '.' -f3`
			verf1=`echo $oldver | cut -d '.' -f1`
			verf2=`echo $oldver | cut -d '.' -f2`
			oldnum=`echo $vernum | sed 's/.$//'`
			newnum=`expr $oldnum + 1`
			newver="$verf1.$verf2.$newnum\'"
			sed -i "s/$oldver\$/$newver/g" $file
		fi
	fi
done

git add -A
git commit -m $1
else
echo No commit message found, please add a message.
fi

	


