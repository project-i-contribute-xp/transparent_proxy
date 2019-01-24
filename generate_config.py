import argparse
import json
import subprocess

# 1. read json data from config file
parser = argparse.ArgumentParser(description="generate config file based on user choose")
parser.add_argument("config_file")
arguments = parser.parse_args()
print(arguments.config_file)

# 2. parse json
fp = open(arguments.config_file)
print(fp)
json_data = json.load(fp)
# print(json_data)
# 3. if it's array, ask user to choose which server to use
index = 0
for server in json_data['configs'] :
     # print("[{0}]{1}".format(index, server['server']))
     print("config/config_{0:02}.json".format(index))
     with open("config/config_{0:2}.json".format(index), 'w') as outfile:
         json.dump(server, outfile)
     index = index + 1
     # subprocess.run(["ls"])
     # subprocess.run("./get_ip_address.sh", shell=True)

# 4. save user choose data into config/config.json
