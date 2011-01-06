#/bin/bash 

PRODUCT="fascinate"
OUTDIR="../out/target/product/$PRODUCT"

rm -rf temp/
mkdir temp
mkdir temp/system

echo "Copying /system ..."
cp -R $OUTDIR/system/ temp/

echo "Copying tools for otapackage ..."
cp -R tools/* temp/

echo "Copying zImage ..."
cp ../kernel/samsung/2.6.35/arch/arm/boot/zImage temp/zImage

echo "Copying kernel modules ..."
cp -R ../kernel/samsung/2.6.35/drivers/net/wireless/bcm4329/bcm4329.ko temp/system/modules/

echo "Removing .git files"
find temp/ -name '.git' -exec rm -r {} \;

echo "Compressing otapackage ..."
pushd temp
zip -r ../$OUTDIR/cyanogenmod7-$PRODUCT-unsigned.zip ./
popd

echo "Signing otapackage ..."
java -jar SignApk/signapk.jar SignApk/certificate.pem SignApk/key.pk8 $OUTDIR/cyanogenmod7-$PRODUCT-unsigned.zip $OUTDIR/cyanogenmod7-$PRODUCT.zip

rm $OUTDIR/cyanogenmod7-$PRODUCT-unsigned.zip
rm -rf temp/
echo "cyanogenmod7-$PRODUCT.zip is at $OUTDIR"
echo "Done."
