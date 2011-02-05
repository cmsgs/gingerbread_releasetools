#/bin/bash 

VERSION=$1
PRODUCT="captivate"
OUTDIR="../out/target/product/$PRODUCT"

if [ ! $VERSION = "" ]
then
	if [ -f radio-tools/radio/$VERSION/modem.bin ]
	then
    		rm -rf temp/
		mkdir temp

		echo "Copying tools for radiopackage ..."
		cp -R radio-tools/$PRODUCT/* temp/

		echo "Copying radio image ..."
		cp -R radio-tools/radio/$VERSION/modem.bin temp/

		echo "Removing .git files"
		find temp/ -name '.git' -exec rm -r {} \;

		echo "Compressing radiopackage ..."
		pushd temp
		zip -r ../$OUTDIR/cm7-$PRODUCT-radio-unsigned.zip ./
		popd

		echo "Signing radiopackage ..."
		java -jar SignApk/signapk.jar SignApk/certificate.pem SignApk/key.pk8 $OUTDIR/cm7-$PRODUCT-radio-unsigned.zip $OUTDIR/cm7-$PRODUCT-radio-$VERSION.zip

		rm $OUTDIR/cm7-$PRODUCT-radio-unsigned.zip
		rm -rf temp/
		echo "cm7-$PRODUCT-radio-$VERSION is at $OUTDIR"
		echo "Done."
	else
		echo "Unsupported radio version: $VERSION"
		exit
	fi
else
	echo -e "\n";
	echo "USAGE: radio_captivate.sh version";
	echo "EXAMPLE: radio_captivate.sh JPM";
	echo "Supported Versions:";
	ls radio-tools/radio/
	echo -e "\n";
fi

