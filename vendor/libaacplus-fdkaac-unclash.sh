#!/bin/sh

EXTRE='-r'
sed -r < /dev/null
if [ $? -ne 0 ]; then
    EXTRE='-E'
fi

for FILE in `find libSBRenc/src -type f`
do
    echo $FILE
    sed -i $EXTRE -e 's/ (v_Huff_envelopeLevel[CL]1[01][TF])/ _\1/' \
                  -e 's/ (v_Huff_NoiseLevel[CL]11T)/ _\1/' \
                  -e 's/ (bookSbrEnvBalance[CL]1[01][TF])/ _\1/' \
                  -e 's/ (bookSbrNoiseBalance[CL]11T)/ _\1/' $FILE
done
