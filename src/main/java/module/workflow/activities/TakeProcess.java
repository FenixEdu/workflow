/*
 * @(#)TakeProcess.java
 *
 * Copyright 2009 Instituto Superior Tecnico
 * Founding Authors: Luis Cruz, Paulo Abrantes
 * 
 *      https://fenix-ashes.ist.utl.pt/
 * 
 *   This file is part of the Case Handleing Based Workflow Module.
 *
 *   The Case Handleing Based Workflow Module is free software: you can
 *   redistribute it and/or modify it under the terms of the GNU Lesser General
 *   Public License as published by the Free Software Foundation, either version 
 *   3 of the License, or (at your option) any later version.
 *
 *   The Workflow Module is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public License
 *   along with the Workflow Module. If not, see <http://www.gnu.org/licenses/>.
 * 
 */
package module.workflow.activities;

import module.workflow.domain.WorkflowProcess;

import org.fenixedu.bennu.core.domain.User;

/**
 * 
 * @author Luis Cruz
 * @author Paulo Abrantes
 * 
 */
public class TakeProcess<T extends WorkflowProcess> extends WorkflowActivity<T, ActivityInformation<T>> {

    @Override
    public boolean isActive(T process, User user) {
        return process.isTicketSupportAvailable() && !process.isUserObserver(user) && process.getCurrentOwner() == null;
    }

    @Override
    protected void process(ActivityInformation<T> information) {
        information.getProcess().takeProcess();
    }

    @Override
    public boolean isUserAwarenessNeeded(T process, User user) {
        return false;
    }

    @Override
    public boolean isVisible() {
        return false;
    }
}
