#!/bin/bash

model=THUDM/chatglm-6b
lora_args=""
if [ $# -ge 1 ]; then
  model=$1
fi
if [ $# -ge 2 ]; then
  lora_args="--lora_model_path $2"
fi

CUDA_VISIBLE_DEVICES=0 \
  deepspeed --master_port=10000 examples/chatbot.py \
      --arch_type encoder_decoder \
      --deepspeed configs/ds_config_chatbot.json \
      --model_name_or_path ${model} \
      --do_sample True \
      --temperature 0.95 \
      --top_p 0.7 \
      --prompt_structure "[Round 0]\n问：{input_text}\n答：" \
      ${lora_args}