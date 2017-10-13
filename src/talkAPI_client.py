# coding: utf-8
import pya3rt
import sys
import re

args = sys.argv

#pls write APIKEY
apikey = ""

client = pya3rt.TalkClient(apikey)

result=client.talk(args[1])['results']
print(result[0]['reply'])