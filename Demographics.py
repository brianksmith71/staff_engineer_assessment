import pyodbc
import pandas as pd
from datetime import datetime
import sys



# df = pd.read_excel('C:\Privia Family Medicine 113018.xlsx')

df = pd.read_excel('C:\Privia Family Medicine 113018.xlsx', skiprows=3, names=['Dummy', 'PatientID', 'FirstName', 'MiddleName', 'LastName', 'DOB', 'Sex', 'FavoriteColor',
           'AttributedQ1', 'AttributedQ2', 'RiskQ1', 'RiskQ2', 'RiskIncreasedFlag'])

# df.rename(columns={'Unnamed: 0': 'Dummy',
#                    'Attribution Data for Quarters 1 and 2': 'PatientID',
#                    'Unnamed: 2': 'FirstName',
#                    'Unnamed: 3': 'MiddleName',
#                    'Unnamed: 4': 'LastName',
#                    'Unnamed: 5': 'DOB',
#                    'Unnamed: 6': 'Sex',
#                    'Unnamed: 7': 'FavoriteColor',
#                    'Unnamed: 8': 'AttributedQ1',
#                    'Unnamed: 9': 'AttributedQ2',
#                    'Unnamed: 10': 'RiskQ1',
#                    'Unnamed: 11': 'RiskQ2',
#                    'Unnamed: 12': 'RiskIncreasedFlag'}, inplace=True)

# df[['Dummy','PatientID', 'FirstName', 'MiddleName', 'LastName', 'DOB', 'Sex', 'FavoriteColor', 'AttributedQ1', 'AttributedQ2', 'RiskQ1', 'RiskQ2', 'RiskIncreasedFlag']] = df[['Dummy','PatientID', 'FirstName', 'MiddleName', 'LastName', 'DOB', 'Sex', 'FavoriteColor', 'AttributedQ1', 'AttributedQ2', 'RiskQ1', 'RiskQ2', 'RiskIncreasedFlag']].apply(pd.to_string)

# df['Dummy'] = df['Dummy'].astype("|S")
# df['PatientID'] = df['PatientID'].astype("|S")
# df['FirstName'] = df['FirstName'].astype('|S255')
# df['MiddleName'] = df['MiddleName'].astype('|S255')
# df['LastName'] = df['LastName'].astype('|S255')
# df['DOB'] = df['DOB'].astype('|S255')
# df['Sex'] = df['Sex'].astype('|S255')
# df['FavoriteColor'] = df['FavoriteColor'].astype('|S255')
# df['AttributedQ1'] = df['AttributedQ1'].astype('|S255')
# df['AttributedQ2'] = df['AttributedQ2'].astype('|S255')
# df['RiskQ1'] = df['RiskQ1'].astype('|S255')
# df['RiskQ2'] = df['RiskQ2'].astype('|S255')
# df['RiskIncreasedFlag'] = df['RiskIncreasedFlag'].astype('|S255')

# convert_dict = {'Dummy': str,
#                 'PatientID': str,
#                 'FirstName': str,
#                 'MiddleName': str,
#                 'LastName': str,
#                 'DOB': str,
#                 'Sex': str,
#                 'FavoriteColor': str,
#                 'AttributedQ1': str,
#                 'AttributedQ2': str,
#                 'RiskQ1': str,
#                 'RiskQ2': str,
#                 'RiskIncreasedFlag': str}
#
# df.astype(str)['Dummy'].map(lambda x:  type(x))
#
# df = df.astype(convert_dict)

print(df.dtypes)

for index, row in self.df.iterrows():
    cursor.execute(
        "INSERT INTO dbo.Demographics([ID], [ProviderGroup], [FileDate],[FirstName], [MiddleName], [LastName], [DOB], [Sex], [FavoriteColors]) values (?,?,?,?,?,?,?,?,?)",
        row['ID'], self.providerGroup, self.fileDate, row['FirstName'], row['MiddleName'], row['LastName'], row['DOB'],
        row['Sex'], row['FavoriteColor'])

#list(df.itertuples(index=False, name=None))

#df[[[4]]] = df[[[4]]].astype(str)

#df[4].astype(str)
#df[4].apply(str)
#df[4] = df[4].astype(str)

#df.index = df.index.map(str)
#print(df)

#with pd.option_context('display.max_rows', None, 'display.max_columns', None):  # more options can be specified also
#    print(df)

#for col in df.columns:
#    print(col)

connStr = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                         "Server=localhost;"
                         "Database=PersonDatabase;"
                         "Trusted_Connection=yes;")

delete_data = "DELETE dbo.Demographics;"

cursor = connStr.cursor()

cursor.execute(delete_data)

cursor.close()

#connStr = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=PersonDatabase;Trusted_Connection=yes')
cursor = connStr.cursor()

# for index,row in df.iterrows():
#     cursor.execute(
#     "INSERT INTO dbo.Demographics ([Dummy], [PatientID], [FirstName], [MiddleName], [LastName], [DOB], [Sex], [FavoriteColor], [AttributedQ1],[AttributedQ2], [RiskQ1], [RiskQ2], [RiskIncreasedFlag]) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
#     row['Dummy'],
#     row['PatientID'],
#     row['FirstName'],
#     row['MiddleName'],
#     row['LastName'],
#     row['DOB'],
#     row['Sex'],
#     row['FavoriteColor'],
#     row['AttributedQ1'],
#     row['AttributedQ2'],
#     row['RiskQ1'],
#     row['RiskQ2'],
#     row['RiskIncreasedFlag'])
#
# cursor.commit()










    #list(df.itertuples(index=False, name=None))


cursor.close()
connStr.close()

