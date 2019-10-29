package com.samsolutions.roles;

import org.springframework.security.core.GrantedAuthority;

public enum Roles implements GrantedAuthority {
    ROLE_PATIENT,
    ROLE_RECEPTIONIST,
    ROLE_ADMIN,
    ROLE_MEDIC;

    public String getAuthority() {
        return name();
    }
}