#/bin/bash 

PRODUCT="fascinate"
OUTDIR="../out/target/product/$PRODUCT"

rm -rf temp/
mkdir temp
mkdir temp/system

echo "Copying tools for otapackage ..."
cp -R efs-tools/* temp/

echo "Removing .git files"
find temp/ -name '.git' -exec rm -r {} \;

echo "Compressing otapackage ..."
pushd temp
zip -r ../$OUTDIR/$PRODUCT-efsbackup-unsigned.zip ./
popd

echo "Signing otapackage ..."
java -jar SignApk/signapk.jar SignApk/certificate.pem SignApk/key.pk8 $OUTDIR/$PRODUCT-efsbackup-unsigned.zip $OUTDIR/$PRODUCT-efsbackup.zip

rm $OUTDIR/$PRODUCT-efsbackup-unsigned.zip
rm -rf temp/
echo "$PRODUCT-efsbackup.zip is at $OUTDIR"
echo "Done."
