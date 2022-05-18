#!/bin/bash
declare -a CIRCUITS=( pedersen poseidon mimc sha256 )

cd circuits

compile_circuit() {
    echo "Compiling ${1}.circom..."

    # compile circuit

    circom ${1}.circom --r1cs
    snarkjs r1cs info ${1}.r1cs

    # Start a new zkey and make a contribution
    snarkjs g16s ${1}.r1cs build/ptau_15.ptau ${1}_0000.zkey
    snarkjs zkey contribute ${1}_0000.zkey ${1}_final.zkey --1="guy" -v -e="eNtRoPy"


    rm ${1}.r1cs
    rm ${1}_0000.zkey
}

if [ -f ./build/ptau_15.ptau ]; then
    echo ""
else
    echo 'Downloading ptau_15.ptau'
    curl https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_15.ptau -o build/ptau_15.ptau
fi

for NAME in "${CIRCUITS[@]}"
do
    time compile_circuit $NAME
    echo "⏱ ⏱ ⏱"
done

cd ../