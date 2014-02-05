/**
 * Copyright 2013 Red Hat, Inc.
 *
 * This software is licensed to you under the GNU General Public
 * License as published by the Free Software Foundation; either version
 * 2 of the License (GPLv2) or (at your option) any later version.
 * There is NO WARRANTY for this software, express or implied,
 * including the implied warranties of MERCHANTABILITY,
 * NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
 * have received a copy of GPLv2 along with this software; if not, see
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
 */

/**
 * @ngdoc object
 * @name  Bastion.systems.controller:SystemPackagesController
 *
 * @requires $scope
 * @requires SystemPackage
 * @requires SystemTask
 * @requires gettext
 * @requires Nutupane
 *
 * @description
 *   Provides the functionality for the system packages list and actions.
 */
angular.module('Bastion.systems').controller('SystemOrchestrateController',
    ['$scope', 'System',  'gettext', 'Nutupane',
    function ($scope, System, gettext, Nutupane) {
        var packagesNutupane, packageActions, openEventInfo;

        var openEventInfo = function (event) {
            $scope.transitionTo('systems.details.tasks.details', {taskId: event.id});
        };

        $scope.template = ''+
'{"sequence":'+ "\n" +
'   [{"Package::Install":{"package":"redis"}},'+ "\n" +
'    {"concurrence":'+ "\n" +
'      [{"Service::Restart":{"service":"redis"}},'+ "\n" +
'       {"Service::Restart":{"service":"puppet"}}]}]}';

        $scope.orchestrate = function () {
            var template = $scope.template;
            System.orchestrate({uuid: $scope.system.uuid, template: template}, openEventInfo);
        };
    }
]);
