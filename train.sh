#!/usr/bin/env bash
# run_dataset.sh
# $1 is the HTCondor Process ID (0…9)

JOB_ID="$1"

nvidia-smi

echo "# Move directory contents"
mv ./train/* .

python ./train.py \
    --dataset=cifar10 \
    --batch_size=64 \
    --accum_iter=1 \
    --eval_frequency=100 \
    --epochs=3000 \
    --cfg_scale=0.2 \
    --compute_fid \
    --ode_method heun2 \
    --ode_options '{"nfe": 50}' \
    --use_ema \
    --edm_schedule \
    --skewed_timesteps

echo "Finished job ${JOB_ID} on $(hostname)"
