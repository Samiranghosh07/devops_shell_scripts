#!/bin/bash    

clear 

#root access check
function root_access_check()
{
    if [ "$(id -u)" == 0 ];then
      echo "ok, !! you are in root account!!"
    else
      echo ""
      echo "ERROR: !! need root account access to execute the script !!"
      exit 1
    fi
}


#awcli install, configure and remove zipfile 
function install_aws_cli()
{
      if [ -n "$(aws --version)" ];then
          echo "awscli tool installing.........."
          url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
          file="awscliv2.zip"
          curl -s "$url" -o "$file"
      	  unzip awscliv2.zip
          ./aws/install --update
          echo ""
          echo "Version : $(aws --version)"
          rm -rf /root/shell_scripts/"$file"
          echo ""
          echo "awscli tool configuring.............."
          aws configure
       fi
}

#check aws s3 bucket existance
function check_s3_bucket()
{
   read -p "enter s3 bucket name :: " s3_bucket_name
   command=$(aws s3 ls "s3://$s3_bucket_name")
   if [ ! "$command" ]; then
        echo "ERROR: !! s3 bucket not exist !!"
        exit 1
   fi
}

#copy local system logs to aws s3 bucket
function copy_logs_to_s3_bucket()
{
   read -p "enter s3 bucket name :: " s3_bucket_name

   src_path="/var/log/"
   aws s3 cp "$src_path" "s3://$s3_bucket_name" --recursive
   echo "!! Log files are successfully copied to target s3 bucket $(s3_bucket_name)"
}


#copy aws s3 bucket logs to local system
function copy_logs_to_local_system()
{
   read -p "enter s3 bucket name :: " s3_bucket_name

   target_path="/opt/mylog/collection/"
   aws s3 cp "s3://$s3_bucket_name/" "$target_path" --recursive
   echo "!! Log files are successfully copied from S3 bucket : $s3_bucket_name to local system : $(hostname -s)"
}


#copy aws s3 bucket logs to another s3 bucket
function copy_logs_from_s3_to_s3()
{
   read -p "enter source s3 bucket name :: " src_s3_bucket_name
   read -p "enter target s3 bucket name :: " dest_s3_bucket_name

   aws s3 cp "s3://$src_s3_bucket_name/" "s3://$dest_s3_bucket_name/" --recursive
   echo "!! Log files are successfully copied from Source : $src_s3_bucket_name to Target : $dest_s3_bucket_name"
}


root_access_check


#MENU DRIVEN PROGRAM
#======================

while($1) 
do
   echo "Welcome To Logcollet script"
   echo "==========================="
   echo "
         1. Check aws cli tool exist.
         2. Check aws s3 bucket exist.
         3. Copy logs from local system to s3 bucket.
         4. Copy logs from s3 bucket to local system.
         5. Copy logs from one s3 bucket to another s3 bucket.
         6. Exit from script.
   "
   read -p "enter your choice with number ::" ch
   case $ch in 
      
       1) install_aws_cli
           ;;
     
       2) check_s3_bucket
           ;;
      
       3) copy_logs_to_s3_bucket
           ;;

       4) copy_logs_to_local_system
           ;;

       5) copy_logs_from_s3_to_s3
           ;;

       6) read -p "are you want to exit from script (y/n)" ensure
           if [ "$ensure" == "y" ];then 
                exit 1
           else
                echo "continue.."
                clear 
           fi
esac
done
