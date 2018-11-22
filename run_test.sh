
#!/bin/bash

#Setting environment variable
export PYTHONPATH=~/document_week1/src

#Remove training alignments if it exits previously
rm -rf ~/document_week1/data/train

#Align raw_train for classifier to create embeddings
python ~/document_week1/src/align/align_dataset_mtcnn.py \
~/document_week1/data/raw/train_raw \
~/document_week1/data/train \
--image_size 160

#Remove test alignments if it exits previously 
rm -rf ~/document_week1/data/test

#Align raw_test for classifier to remove margins
python ~/document_week1/src/align/align_dataset_mtcnn.py \
~/document_week1/data/raw/test_raw \
~/document_week1/data/test \
--image_size 160

#Train model 
python ~/document_week1/src/classifier.py TRAIN ~/document_week1/data/train/ ~/document_week1/models/20180402-114759/20180402-114759.pb ~/document_week1/models/my_classifier.pkl

#Test matches against embeddings in pkl file
python ~/document_week1/src/classifier.py CLASSIFY ~/document_week1/data/test/ ~/document_week1/models/20180402-114759/20180402-114759.pb ~/document_week1/models/my_classifier.pkl
