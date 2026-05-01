import mysql.connector
import subprocess

db = mysql.connector.connect(
    host="10.0.2.15",   
    port=3306,             
    user="user", 
    password="123",
    database="error_helper",
    charset="utf8mb4"
)

cursor = db.cursor(dictionary=True)


def leia_viga(output):
    cursor.execute("SELECT * FROM errors")
    rows = cursor.fetchall()

    for row in rows:
        if row["veateade"].lower() in output.lower():
            return row
    return None


def käivita_käsk(command):
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    return result.stdout + result.stderr


def main():
    while True:
        cmd = input("\nSisesta Linux käsk: ")

        output = käivita_käsk(cmd)

        print("\n--- Tulemus ---")
        print(output)

        viga = leia_viga(output)

        if viga:
            print("\n⚠️ VIGA LEITUD")
            print("Selgitus:", viga["selgitus"])
            print("Parandus:", viga["parandus"])

            if viga["alternatiivne_parandus"]:
                print("Alternatiiv:", viga["alternatiivne_parandus"])

            choice = input("\nKas käivitada parandus? (y/n): ")

            if choice.lower() == "y":
                fix_output = käivita_käsk(viga["parandus"])
                print("\n--- Parandus tulemus ---")
                print(fix_output)
        else:
            print("\n✅ Viga ei leitud")


if __name__ == "__main__":
    main()
