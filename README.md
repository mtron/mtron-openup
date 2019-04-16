# openup

This puppet module installs and configures [openup](https://mtier.org/solutions/apps/openup/), the OpenBSD package update service by [M:Tier](https://mtier.org/). Openup can be run standalone or via cron to check for - and install - security updates in packages and the base system by using the regular OpenBSD pkg tools.  

M:Tier provides these updates free of charge for the current OpenBSD stable release. They also offer backports for the two most recent OpenBSD releases to [subscribers](https://stable.mtier.org/subscriptions).  

*Notice: I am not affiliated to M:Tier in any way. If you experience Problems with an update [contact M:Tier](https://stable.mtier.org/)*

#### Table of Contents

1. [Overview - What is the openup module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with openup](#setup)
  * [Examples](#examples)
4. [Usage - The classes and defined types available for configuration](#usage)
  * [Classes and Defined Types](#classes-and-defined-types)
5. [Limitations](#limitations)
6. [Contributors](#contributors)
7. [License](#license)

## Overview

This puppet module installs and configures openup, the OpenBSD package update service by [M:Tier](https://mtier.org/solutions/apps/openup/) useable free of charge for the current OpenBSD stable release. M:Tier provides security updates for OpenBSD packages built from the official OpenBSD ports tree with the most recent security fixes.

## Module description

This module downloads and installs the latest [openup](https://mtier.org/solutions/apps/openup/) version which is a small utility for OpenBSD that can be run standalone or from cron(8) and that checks for security updates in both packages and the base system. It uses the standard pkg tools (syspatch for the base system and pkg_add for Packages)

This module is suitable for OpenBSD systems only. It currently requires min. puppet 4.x

## Setup

openup will affect the following parts of your system:

* openup binary installed to /usr/local/sbin  
* openup configuration file installed to /etc/openup.conf  

Including the main class is enough to install and configure the openup program

```puppet
include openup
```
#### Examples

Check for Package updates via cronjob and mail the result

```puppet
class { 'openup':
  admin_email    => 'webmaster@mydomain.com',
  enable_cronjob => true,
}
```

Auto-install found updates:

```puppet
class { 'openup':
  admin_email         => 'webmaster@mydomain.com',
  enable_cronjob      => true,
  autoinstall_updates => true,
}
```

Overly complicated:

```puppet
class { 'openup':
  openup_url          => 'https://stable.mtier.org/openup',
  openbsd_mirror      => 'https://cdn.openbsd.org/pub/OpenBSD',
  openbsd_mtier_url   => 'https://stable.mtier.org/updates',
  openbsd_vul_db      => 'https://stable.mtier.org/vuxml',
  admin_email         => 'webmaster@mydomain.com',
  sender_email        => 'monitoring@mydomain.com',
  enable_cronjob      => true,
  autoinstall_updates => true,
}
```

## Usage

### Classes and Defined Types

#### Class: `openup`

Primary class and entry point of the module. Installs openup in `/usr/local/sbin`

**Parameters within `openup`:**

##### `openup_url`
default: https://stable.mtier.org/openup  
descr  : URL to the latest openup version  

##### `openbsd_mirror`
default: https://cdn.openbsd.org/pub/OpenBSD  
descr  : OpenBSD mirror to use  

##### `openbsd_mtier_url`
default: https://stable.mtier.org/updates  
descr  : URL for the M:Tier packages update service  

##### `openbsd_vul_db`
default: https://stable.mtier.org/vuxml  
descr  : URL for the current OpenBSD release of the latest vulnerabilities database  

##### `owner`
default: root  
descr  : The system user that will run the update check  

##### `group`
default: daemon  
descr  : The system group that will run the update check  

##### `mode`
default: 0755
descr  : Default file mode for the openup binary  

##### `admin_email`
default: undef  
descr  : The email address of the admin user. This user will receive the report with available or installed updates  

##### `sender_email`
default: openup@$::fqdn  
descr  : The report sender email address  

##### `enable_cronjob`
default: false  
descr  : Automatic update check via cron. *Requires parameter admin_email to be set*  

##### `autoinstall_updates`
default: false  
descr  : Automatic installation of available updates. *Requires: parameter enable_cronjob to be set*  

## Limitations

Updates are only provided free of charge for the current OpenBSD stable release. M:Tire also offer backports for the two most recent OpenBSD releases to subscribers. See: https://stable.mtier.org/subscriptions for more information.

## Contributors

* [mtron](https://github.com/mtron)
* [Frank Groeneveld](https://github.com/frenkel) (Original Author before the fork)

Features request and new contributions are always welcome!

## License
Copyright (c) 2019, mtron  
Copyright (c) 2014, Frank Groeneveld  
All rights reserved.  

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:  

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.  

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.  

* Neither the name of frenkel-openup nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.  

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
