# vim: sw=4:ts=4:et
#
# Copyright 2011 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.

%define base_name katello
%define command_name headpin

Name:          %{base_name}-cli-headpin
Summary:       Client package for managing a katello-headpin installation
Group:         Applications/System
License:       GPLv2
URL:           http://www.katello.org
Version:       1.1.1
Release:       1%{?dist}
Source0:       https://fedorahosted.org/releases/k/a/katello/%{name}-%{version}.tar.gz

Requires:      %{base_name}-cli-common
BuildArch:     noarch

Conflicts:     katello-cli

%description
Provides a client package for managing application life-cycle
for Linux systems

%prep
%setup -q

%build

%install
install -d $RPM_BUILD_ROOT%{_bindir}/
install -d $RPM_BUILD_ROOT%{_sysconfdir}/%{command_name}/
install -d $RPM_BUILD_ROOT%{_sysconfdir}/%{base_name}/
install -pm 0644 bin/%{command_name} $RPM_BUILD_ROOT%{_bindir}/%{command_name}
install -pm 0644 etc/client.conf $RPM_BUILD_ROOT%{_sysconfdir}/%{base_name}/client.conf

%files
%attr(755,root,root) %{_bindir}/%{command_name}
%config(noreplace) %attr(644,root,root) %{_sysconfdir}/%{base_name}/client.conf
%doc README LICENSE
#%{_mandir}/man8/%{command_name}.8*



%changelog
* Thu Aug 23 2012 Mike McCune <mmccune@redhat.com> 1.1.1-1
- buildroot and %%clean section is not needed (msuchy@redhat.com)
- Bumping package versions for 1.1. (msuchy@redhat.com)

* Tue Jul 31 2012 Miroslav Suchý <msuchy@redhat.com> 1.0.1-1
- bump up version to 1.0 (msuchy@redhat.com)
- update copyright years (msuchy@redhat.com)
- point Source0 to fedorahosted.org where tar.gz are stored (msuchy@redhat.com)

* Thu Jul 26 2012 Miroslav Suchý <msuchy@redhat.com> 0.1.21-1
- 832462 - making katello-cli-headpin conflict with katello-cli
  (jomara@redhat.com)

* Wed Jul 25 2012 Miroslav Suchý <msuchy@redhat.com> 0.1.20-1
- 817845 - Created a headpin manpage for the cli tool. (adprice@redhat.com)
- 839524 - SAM cli now runs without displaying any errors (adprice@redhat.com)

* Thu May 17 2012 Lukas Zapletal <lzap+git@redhat.com> 0.1.19-1
- 812891 - Adding hypervisor record deletion to katello cli
- 772850 - provider status is not relevant to headpin since repos are not
  sync'ed

* Thu May 10 2012 Lukas Zapletal <lzap+git@redhat.com> 0.1.18-1
- Added version information for headpin

* Fri Apr 27 2012 Lukas Zapletal <lzap+git@redhat.com> 0.1.17-1
- Pull in the latest commands around LDAP Roles and Releases to the headpin cli
- The headpin cli should deliver its own etc file
- Merging headpin flags into master

* Fri Apr 27 2012 Lukas Zapletal <lzap+git@redhat.com>
- Pull in the latest commands around LDAP Roles and Releases to the headpin cli
- The headpin cli should deliver its own etc file
- Merging headpin flags into master

* Wed Jan 25 2012 Bryan Kearney <bkearney@redhat.com> 0.1.15-1
- 754856: Add shell history to the local .headpin directory instead of .katello
  (bkearney@redhat.com)

* Mon Jan 23 2012 Bryan Kearney <bkearney@redhat.com> 0.1.14-1
- Add in the latest command line features from katello proper
  (bkearney@redhat.com)

* Fri Dec 16 2011 Bryan Kearney <bkearney@redhat.com> 0.1.13-1
- 758447: Add headpin prompt to the config file (bkearney@redhat.com)
- The default location for the headpin path is /headpin (bkearney@redhat.com)

* Wed Oct 26 2011 Bryan Kearney <bkearney@redhat.com> 0.1.12-1
- Move the headpin packaegs to a new location (bkearney@redhat.com)

* Mon Oct 24 2011 Bryan Kearney <bkearney@redhat.com> 0.1.11-1
- new package built with tito


