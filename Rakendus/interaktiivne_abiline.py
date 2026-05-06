import mysql.connector

import subprocess





def loo_db_yhendus():

    try:

        db = mysql.connector.connect(

            host="10.0.2.15",

            port=3306,

            user="user",

            password="123",

            database="error_helper",

            charset="utf8mb4"

        )

        return db

    except mysql.connector.Error as e:

        print("\n❌ Andmebaas ei ole kättesaadav.")

        print("Põhjus:", e)

        return None





db = loo_db_yhendus()

if db is None:

    exit()



cursor = db.cursor(dictionary=True)





FORBIDDEN_PATHS = ["/root", "/etc", "/usr", "/bin", "/sbin"]

FORBIDDEN_COMMANDS = ["chmod", "chown", "rm", "mv", "sudo"]





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





def on_viga(output):

    veasõnad = ["error", "failed", "denied", "not found", "exception", "traceback"]

    tekst = output.lower()

    return any(s in tekst for s in veasõnad)





def sisaldab_keelatud_teed(command):

    return any(path in command for path in FORBIDDEN_PATHS)





def on_ohtlik_parandus(command):

    return any(command.strip().startswith(c) for c in FORBIDDEN_COMMANDS)





def main():

    while True:

        cmd = input("\nSisesta Linux käsk: ").strip().lower()

        if cmd in ["quit", "exit", "q", "stop"]:
           print("Sulgen.")
           break

        output = käivita_käsk(cmd)



        print("\n--- Tulemus ---")

        print(output)



        viga = leia_viga(output)



        if viga:

            print("\n⚠️ VIGA LEITUD")

            print("Selgitus:", viga["selgitus"])



            if "permission denied" in output.lower() and sisaldab_keelatud_teed(cmd):

                print("Parandus: Süsteemikataloogide õiguseid ei ole turvaline automaatselt muuta.")

                print("Rakendus ei paku paranduskäsku.")

                continue



            print("Parandus (informatiivne):", viga["parandus"])



            if viga["alternatiivne_parandus"]:

                print("Alternatiiv:", viga["alternatiivne_parandus"])



            if on_ohtlik_parandus(viga["parandus"]):

                print("\n⚠️ See parandus on hinnatud ohtlikuks.")

                print("Rakendus ei käivita seda käsku automaatselt.")

                continue



            choice = input("\nKas käivitada parandus? (y/n): ").lower()



            if choice == "y":

                fix_output = käivita_käsk(viga["parandus"])

                print("\n--- Parandus tulemus ---")

                print(fix_output)

            else:

                continue



        else:

            if on_viga(output):

                print("\n⚠️ Viga tuvastati, kuid sellele puudub kirje andmebaasis.")

            else:

                print("\n✅ Viga ei tuvastatud")





if __name__ == "__main__":

    main()
