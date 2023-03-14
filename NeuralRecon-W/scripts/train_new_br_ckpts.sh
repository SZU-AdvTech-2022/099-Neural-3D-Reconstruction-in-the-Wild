#!/bin/bash
set -x
set -u


now=$(date +"%Y%m%d_%H%M%S")
jobname="train-$1-$now"
echo "job name is $jobname"

config_file=$2
mkdir -p log
mkdir -p logs/${jobname}
cp ${config_file} logs/${jobname}

export CUDA_VISIBLE_DEVICES="3,2,1,0"
python train.py --cfg_path ${config_file} \
  --num_gpus $3 --num_nodes $4 \
  --num_epochs 50 --batch_size 2048 --test_batch_size 512 --num_workers 16 \
  --ckpt_path '/mnt/d/Workspace/NeuralRecon-W/ckpts/train-new_brandenburg_101-w-20221109_090307/{epoch:d}/epoch=24-step=3572588.ckpt' \
  --exp_name ${jobname} 2>&1|tee log/${jobname}.log \