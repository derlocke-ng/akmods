#!/bin/sh

set -oeux pipefail

ARCH="$(rpm -E '%_arch')"
KERNEL="$(rpm -q "${KERNEL_NAME}" --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
RELEASE="$(rpm -E '%fedora')"

#cp /tmp/ublue-os-akmods-addons/rpmbuild/SOURCES/_copr_ublue-os-akmods.repo /etc/yum.repos.d/
#cat >> /etc/yum.repos.d/tuxedo.repo<< EOF
#[tuxedo]
#name=tuxedo
#baseurl=https://rpm.tuxedocomputers.com/fedora/40/x86_64/base
#enabled=1
#gpgcheck=1
#gpgkey=https://rpm.tuxedocomputers.com/fedora/40/0x54840598.pub.asc
#skip_if_unavailable=False
#EOF

### BUILD ryzen-smu (succeed or fail-fast with debug output)
#dnf install -y \
#    dkms \
#    tuxedo-drivers*.noarch
#    tuxedo-drivers*.fc${RELEASE}.${ARCH}

git clone https://github.com/tuxedocomputers/tuxedo-drivers
cd tuxedo-drivers
make install
## how to create (a)kmods?
akmods --force --kernels "${KERNEL}" --kmod tuxedo-drivers

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_io.ko.xy > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_keyboard.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb05_kbd_backlight.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb05_fan_control.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)


modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb04_power_profiles.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb04_kbd_backlight.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb02_nvidia_power_ctrl.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb05_sensors.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)


modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb05_power_profiles.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb05_keyboard.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb05_ec.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb04_wmi_bs.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)


modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb04_wmi_ab.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb04_sensors.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_nb04_keyboard.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/tuxedo_compatibility_check.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)


modinfo /usr/lib/modules/${KERNEL}/extra/clevo_wmi.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)

modinfo /usr/lib/modules/${KERNEL}/extra/clevo_acpi.ko.xz > /dev/null \
|| (find /var/cache/akmods/tuxedo-drivers/ -name \*.log -print -exec cat {} \; && exit 1)




#rm -f /etc/yum.repos.d/_copr_ublue-os-akmods.repo
rm -f /etc/yum.repos.d/tuxedo.repo
