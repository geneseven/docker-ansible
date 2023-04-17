from ansible.plugins.action import ActionBase
import subprocess
import json

class ActionModule(ActionBase):

    def run(self, tmp=None, task_vars=None):
        facts = {}
        if task_vars is None:
            task_vars = dict()

        result = super(ActionModule, self).run(tmp, task_vars)

        if result.get('skipped'):
            return result

        context = task_vars.get('context', {})
        inventory_hostname = task_vars.get('inventory_hostname' , '')
        
        for k in task_vars['keys']:
            p = subprocess.Popen("/getpillar " + k +  " " + inventory_hostname, stdout=subprocess.PIPE, shell=True)
            (output, err) = p.communicate()
            ## Wait for date to terminate. Get return returncode
            p_status = p.wait()
            context[k] = json.loads(output.decode('utf-8'))


        result['failed'] = False
        result['ansible_facts'] = {'context': context}
        result['changed'] = False
        return result
