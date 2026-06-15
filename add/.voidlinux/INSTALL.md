## Void Linux Install Notes

These steps cover using `cfdisk` to create the partitions before installing Void Linux.

### Identify the target disk

List disks first so you do not partition the wrong device:

```bash
lsblk
```

Typical disk names:

- SATA SSD/HDD: `/dev/sda`
- NVMe SSD: `/dev/nvme0n1`
- Virtio disk: `/dev/vda`

Replace the disk name below with the correct one for your system.

### Open `cfdisk`

For example, on an NVMe disk:

```bash
cfdisk /dev/nvme0n1
```

If prompted, choose `gpt` unless you specifically need legacy BIOS with `dos`.

### Create the partitions

Recommended layout for a UEFI system:

1. `512M` EFI System partition
2. `4G` swap partition
3. Remaining space for root `/`

Inside `cfdisk`:

1. Select `Free space`
2. Choose `New`
3. Enter the partition size
4. Choose `Type` and set the correct type
5. Repeat for each partition
6. Choose `Write`
7. Type `yes`
8. Choose `Quit`

Partition types:

- EFI partition: `EFI System`
- Swap partition: `Linux swap`
- Root partition: `Linux filesystem`

Example result on `/dev/nvme0n1`:

- `/dev/nvme0n1p1` -> EFI
- `/dev/nvme0n1p2` -> swap
- `/dev/nvme0n1p3` -> root

### Format the partitions

```bash
mkfs.vfat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
```

For SATA or Virtio disks, the names would look like `/dev/sda1` or `/dev/vda1` instead.

### Mount the target system

```bash
mount /dev/nvme0n1p3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi
```

At this point the disk is ready for the standard Void Linux installation steps such as `xbps-install`, `xgenfstab`, `chroot`, and bootloader setup.

### Optional BIOS layout

If you are installing in legacy BIOS mode, you can usually skip the EFI partition and use:

1. `4G` swap
2. Remaining space for root `/`

That would typically become:

- `/dev/sda1` -> swap
- `/dev/sda2` -> root
