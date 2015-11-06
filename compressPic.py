# import Image
# import os
# import os.path
# import sys
# path = sys.argv[0].split('.')[0]
# small_path = (path[:-1] if path[-1]=='/' else path) +'_small'
# if not os.path.exists(small_path):
#     os.mkdir(small_path)
# def pressPic(work_name):
# 	base_path='.\\static\\upfile\\'
# 	fp=base_path+work_name
# 	img = Image.open(fp)
# 	w, h = img.size
# 	if not os.path.exists('.\\static\\small_upfile'):
# 		os.mkdir('.\\static\\small_upfile')
#         img.resize((w/2, h/2)).save('.\\static\\small_upfile\\'+work_name, "JPEG")
#         print fp


from __future__ import print_function
import os, sys
from PIL import Image
def pressPic(work_name):
	base_path='.\\static\\upfile\\'
	fp=base_path+work_name
	img = Image.open(fp)
	w, h = img.size
	if not os.path.exists('.\\static\\small_upfile'):
		os.mkdir('.\\static\\small_upfile')
	
	img.thumbnail((w/2,h/2))

	img.save('.\\static\\small_upfile\\'+work_name, "JPEG")
