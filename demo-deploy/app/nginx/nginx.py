#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import jinja2

def render(j2_path, context):
  path, filename = os.path.split(j2_path)
  return jinja2.Environment(
  loader=jinja2.FileSystemLoader(path or './')
  ).get_template(filename).render(context)


try:
  context={}

  if not 'DOMAIN_NAME' in os.environ:
    raise Exception('DOMAIN_NAME is not define!')

  context['Domain'] = os.environ.get('DOMAIN_NAME')

  result = render('/tmp/hello.conf.j2', context)

  with open("/etc/nginx/conf.d/hello.conf", "w") as w:
      w.write(result)

except:
  print("Unexpected error:", sys.exc_info()[0])
  raise
