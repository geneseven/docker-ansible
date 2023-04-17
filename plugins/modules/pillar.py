#!/usr/bin/python3

DOCUMENTATION = '''
---
module: gen_hyperv_vm
short_description: set variable to gen_hyperv_vm
'''

EXAMPLES = '''
- name:
  gen_hyperv_vm: {}
'''

def main():
    fields = {}
    module = AnsibleModule(argument_spec=fields)
    module.exit_json(changed=False)

from ansible.module_utils.basic import *

if __name__ == '__main__':
    main()
