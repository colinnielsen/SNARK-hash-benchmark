#!/bin/bash
declare -a CIRCUITS=( pedersen poseidon mimc sha256 )

cd circuits

if [ -f ./build/ptau_15.ptau ]; then
    echo ""
else
    echo 'Downloading ptau_15.ptau'
    curl https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_15.ptau -o build/ptau_15.ptau
fi

for NAME in "${CIRCUITS[@]}"
do
    echo "Compiling ${NAME}.circom..."

    # compile circuit

    circom ${NAME}.circom --r1cs
    snarkjs r1cs info ${NAME}.r1cs

    # Start a new zkey and make a contribution

    snarkjs g16s ${NAME}.r1cs build/ptau_15.ptau ${NAME}_0000.zkey
    snarkjs zkey contribute ${NAME}_0000.zkey ${NAME}_final.zkey --name="guy" -v -e="eNtRoPy"

    rm ${NAME}.r1cs
    rm ${NAME}_0000.zkey
done

cd ../