#! /bin/sh

for f in *.rb
do
	project=`basename $f .rb`
	url=https://kristaps.bsd.lv/$project/snapshots/$project
	suffix=tar.gz
	curl -fO $url.$suffix
	if [ $? -ne 0 ]
	then
		suffix=tgz
		curl -fO $url.$suffix
	fi
	if [ $? -ne 0 ]
	then
		echo "$project: cannot fetch" 1>&2
		continue
	fi
	lead=`tar ztf $project.$suffix | head -n1`
	if [ '.' == "$lead" ]
	then
		version=`tar ztf $project.$suffix | sed -n 2p | cut -d "-" -f 2`
	else
		version=`tar ztf $project.$suffix | sed -n 1p | cut -d "-" -f 2`
	fi
	if [ -z $version ]
	then
		echo "$project.$suffix: cannot get version" 1>&2
		rm -f $project.$suffix
		continue
	fi
	sha=`shasum -a 256 $project.$suffix | awk '{print $1}'`
	echo "Current version: $version"
	echo "Current SHA: $sha"
	sed -e "s!^[ 	]*url .*!	url \"$url-$version.$suffix\"!" \
	    -e "s!^[ 	]*sha256 .*!	sha256 \"$sha\"!" $f > $f.bak
	cmp -s $f $f.bak
	if [ $? -eq 0 ]
	then
		echo "Project is up to date."
		rm -f $project.$suffix
		rm -f $f.bak
		continue
	fi
	diff -u $f $f.bak
	read -p 'Overwrite [y/n] (n)? ' choice
	if [ -z $choice -o $choice == 'n' ]
	then
		rm -f $f.bak
		rm -f $project.$suffix
		continue
	fi
	mv -f $f.bak $f
	rm -f $project.$suffix
done
