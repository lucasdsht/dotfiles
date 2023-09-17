import subprocess
import time

def extend_display(primary_screen, new_screen):
    subprocess.call(["xrandr", "--output", primary_screen, "--auto", "--output", new_screen, "--auto", "--right-of", primary_screen])
    subprocess.call(["feh", "--bg-fill", "/home/lucasdcht/.config/qtile/assets/wp.png"])

def restore_display(primary_screen, new_screen):
    subprocess.call(["xrandr", "--output", primary_screen, "--auto", "--output", new_screen, "--off"])
    subprocess.call(["qtile", "cmd-obj", "-o", "cmd", "-f", "restart"])

def main():
    primary_screen = "eDP-1"
    previous_screens = set()
    
    while True:
        output = subprocess.check_output(["xrandr"]).decode("utf-8")
        connected_screens = set(line.split()[0] for line in output.splitlines() if " connected" in line)

        new_screens = connected_screens - previous_screens
        if new_screens:
            print("New screen detected:", new_screens)
            for screen in new_screens:
                extend_display(primary_screen, screen)

        removed_screens = previous_screens - connected_screens
        if removed_screens:
            print("Screen disconnected:", removed_screens)
            for screen in removed_screens:
                restore_display(primary_screen, screen)

        previous_screens = connected_screens
        time.sleep(5)  

if __name__ == "__main__":
    main()

