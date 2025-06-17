rm isa -r
cp isa_origs isa -r
rm isa/macros/scalar/* 

for i in `ls isa_origs/macros/scalar`;
do
    python pre_h_ext.py -c ../vsim/e603_defines.h -i isa_origs/macros/scalar/$i -o isa/macros/scalar/$i
done


rm env -rf
cp env_origs env -r

for i in p pm pt v;
do
    # process head file
    for j in `ls -1 env_origs/$i/ | grep .h`
    do
        python pre_h_ext.py -c ../vsim/e603_defines.h -i env_origs/$i/$j -o env/$i/$j
    done
done

