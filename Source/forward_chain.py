import re

def is_variable(x):
       return isinstance(x, str) and x[0].isupper()

def parse_kb(raw_kb):
    rules = []
    facts = []
    kb = re.sub(r'(\/\*.*\*\/)|\s', '', raw_kb) #eliminate comments and white space
    sentences = kb.split('.')  #split by '.'
    for sentence in sentences:
        if ':-' in sentence:
            rules.append(sentence)
        elif sentence:
            facts.append(sentence)
    return rules, facts

def parse_queries(raw_queries):
    queries = re.sub(r'\?\-|\s', '', raw_queries)
    queries = queries.split('.')
    raw_queries = raw_queries.split('\n')
    for query in queries:
        if not query:
            queries.remove(query)
    return list(zip(queries, raw_queries))

def parse_fact(fact_string):
    functor = re.search(r'\w+(?=\()', fact_string).group() #lookahead to get funtor
    arguments = re.search(r'(?<=\().+(?=\))', fact_string).group().split(',')  #get arguments list
    return (functor, arguments)

def parse_rule(rule_string):
    left_hand_side = re.search(r'.+(?=\:\-)', rule_string).group()
    left_hand_side = parse_fact(left_hand_side)

    right_hand_side = re.search(r'(?<=\:\-).+', rule_string).group().split('),')    #seperate by ','
    for index, item in enumerate(right_hand_side):
        if index != len(right_hand_side) - 1:
            item += ')'
        right_hand_side[index] = parse_fact(item)

    return(left_hand_side, right_hand_side)

#get tuples response 
def get_response(facts, query, response):
    
    variable_pos = None
    for item in query[1]:
        if is_variable(item):
            variable_pos = query[1].index(item)

    for fact in facts:
        if query[0] == fact[0] and len(query[1]) == len(fact[1]):
            check = True
            for index, item in enumerate(query[1]):
                a = fact[1][index]
                if (item != a):
                    if (index != variable_pos):
                        check = False
                        break
            if check == True:
                response.append((query[1][variable_pos], fact[1][variable_pos]))
    
    return response

#convert rule to fact then check query
def forward_chaining(facts, rules, query, response):
    if query in facts:
        response.append("true")
        return response
    else:
        for index, item in enumerate(facts):
            facts[index] = parse_fact(item)

        #find answer from facts
        query = parse_fact(query)

        if not get_response(facts, query, response):
            for index, item in enumerate(rules):
                rules[index] = parse_rule(item)
                rule = rules[index]

            #if query[0] == rule[0][0]:
                #rule[0]: left  rule[1]: right
                premises = rule[1]

                #new function
                potential_facts = []
                arguments = []  #list of tuple (var_argument, value_argument)

                list_dict = []  #contains fact cases of rule
                for premise in premises:
                    #premise[0] = factor    premise[1] = list of arguments                
                    temp = []
                    #dif
                    if premise[0] == "dif":
                        if list_dict:
                            for dict_fact in list_dict:
                                if dict_fact[premise[1][0]] == dict_fact[premise[1][1]]:
                                    list_dict.remove(dict_fact)
                    else:
                        for fact in facts:
                            if premise[0] == fact[0] and len(premise[1]) == len(fact[1]):   #functor in facts with the same length of arguments
                                #add fact to list dict

                                #append dict to the list if first premise
                                #if not first premise, pass each item from list dict and compare
                                if premises.index(premise) == 0:
                                    dict_fact = dict(zip(premise[1], fact[1]))
                                    list_dict.append(dict_fact)
                                    temp = list_dict
                                else:
                                    dict_fact = dict(zip(premise[1], fact[1]))
                                    for var_argument in premise[1]:
                                        for item in list_dict:
                                            if var_argument in item:
                                                if item[var_argument] == dict_fact[var_argument]:
                                                    dict_fact.update(item)
                                                    new_dict = dict_fact.copy()
                                                    if new_dict not in temp:
                                                        temp.append(new_dict)
                        list_dict = temp
                #convert list_dict to fact
                new_fact = []
                conclusion = rule[0]
                functor = conclusion[0]
                arguments = conclusion[1]
                
                for dict_fact in list_dict:
                    values_argument = []
                    for argument in arguments:
                        values_argument.append(dict_fact[argument])
                    new_fact.append((functor, values_argument))
                    if query[0] == rule[0][0] and query in new_fact:
                        response.append("true")
                        return response

                facts += new_fact
                if query[0] == rule[0][0]:
                    if not get_response(new_fact, query, response):
                        response.append("false")
                    return response

            response.append("false")
            return response

def write_result(choice, raw_query, response):

    f = open("test/result{}.txt".format(choice), "a")
    f.write(raw_query + '\n')
    if len(response) > 1:
        #more than one response
        for index, item in enumerate(response):
            if index != len(response) - 1:
                f.write("{} = {} ;\n".format(item[0], item[1]))
            else:
                f.write("{} = {} .\n".format(item[0], item[1]))
    elif isinstance(response[0], str):
        #response true or false statement
        f.write(response[0] + '.\n')
    else:
        #one value return
        f.write("{} = {} .\n".format(response[0][0], response[0][1]))



#start main
raw_kb = None
raw_queries = None
choice = input("Chon cau test 1 hay 2: ")
if choice == '1':
    f = open("test/kb1.pl", "r")
    raw_kb = f.read()

    f = open("test/test1.txt", "r")
    raw_queries = f.read()

    f = open("test/result1.txt", "w")

elif choice == '2':
    f = open("test/kb2.pl", "r")
    raw_kb = f.read()

    f = open("test/test2.txt", "r")
    raw_queries = f.read()

    f = open("test/result2.txt", "w")

#list queries contains list of tuple (query, raw_query)
list_queries = parse_queries(raw_queries)


for item in list_queries:
    query = item[0]
    raw_query = item[1]
    rules, facts = parse_kb(raw_kb)
    response = []

    forward_chaining(facts, rules, query, response)
    write_result(choice, raw_query, response)

print("Ket qua da luu vao file test/result{}.txt".format(choice))

