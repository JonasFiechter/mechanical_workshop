'''
This file contains the commands dictionary with the methods as values to be 
executed.
The methods appear to be generic, as the idea is to instanciate any state inside 
the system:
    ex. service_order_state => all commands will be related to this state and 
    will opperate with its own table
'''

commands = {
    'show' : show_obj,
    'edit': edit_obj,
    'add': add_obj,
    'remove': remove_obj,
}

def execute(command):
    if command in commands.keys():
        commands[command]()
    
    else:
        return 'invalid option'