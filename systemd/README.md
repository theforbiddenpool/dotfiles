Custom systemd services I use.

### System services
These services must be copied to `/etc/systemd/system`. They must be run as root.
- [bluetooth-off-suspend](./bluetooth-off-suspend.service) → kills bluetooth before `sleep.target`.
	- Created because the bluetooth was preventing my laptop from suspending.
- [nvidia-unload-shutdown](./nvidia-unload-shutdown.service) → removes Nvidia modules before shutdown.
	- Created to remove the annoying shutdown messages of "failed to unmound /oldroot" and "watchdog didn't stop".
	- I've seen this service failing, but I never bothered to investigate, as it doesn't really cause any problems in my experience.

### User services
These services must be copied to `~/.config/systemd/user`.
- [ssh-agent](./ssh-agent.service) → automatically starts SSH key agent
