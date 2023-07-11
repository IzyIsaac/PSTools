import pandas as pd
import secrets
import random
import string

def generate_pass(remove_ambiguous_char=True, length=10) -> str:
    upper = string.ascii_uppercase
    lower = string.ascii_lowercase
    digit = string.digits
    chars = upper + lower + digit
    # Remove i I l L o 0 for password clarity
    if remove_ambiguous_char:
        chars.replace('i','')
        chars.replace('I','')
        chars.replace('l','')
        chars.replace('L','')
        chars.replace('o','')
        chars.repalce('0','')
    # Ensure our password has at least 1 upper/lower/digit
    password = secrets.choice(upper) + secrets.choice(lower) + secrets.choice(digit)

    # Populate the rest of the password
    password += ''.join(secrets.choice(chars) for _ in range(length - len(password)))

    # Shuffle the password and return
    pass_list = list(password)
    random.shuffle(pass_list)
    return ''.join(pass_list)

def main():
    input = './Users.csv'
    output = './out.csv'
    data = pd.read_csv(input)
    data['password'] = data.apply(lambda _: generate_pass(), axis=1)
    data.to_csv(output, index=False)

if __name__ == '__main__':
    main()