# Railway Ubuntu Desktop (XFCE + Firefox)

## Features

- Ubuntu 24.04
- XFCE Desktop
- Firefox
- noVNC Web Access
- x11vnc
- SSH Server
- Root User
- Auto Restart (Supervisor)

---

## Deploy

1. Create a new GitHub repository.
2. Upload all project files.
3. Create a new Railway project.
4. Select **Deploy from GitHub**.
5. Choose your repository.
6. Wait for the build to finish.

---

## Open Desktop

After deployment:

```
https://YOUR-RAILWAY-DOMAIN/vnc.html
```

---

## Login

User:

```
root
```

Password:

```
railway
```

---

## SSH

```
ssh root@YOUR-RAILWAY-DOMAIN
```

Password:

```
railway
```

---

## Included Software

- Firefox
- Nano
- Curl
- Wget
- Htop
- XFCE
- xterm

---

## Change Password

```bash
passwd
```

---

## Update Packages

```bash
apt update
apt upgrade -y
```

---

## Install More Software

```bash
apt install <package>
```

Example:

```bash
apt install git
```

---

## Notes

This project runs inside a Railway container. It is **not a full VPS or virtual machine**. Performance and uptime depend on the resources and behavior of the Railway platform.
