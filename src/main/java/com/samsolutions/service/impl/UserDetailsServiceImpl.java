package com.samsolutions.service.impl;

import com.samsolutions.converter.UserConverter;
import com.samsolutions.dto.RoleDTO;
import com.samsolutions.dto.UserDTO;
import com.samsolutions.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

/**
 * Implements the methods defined in the UserDetails service, needs for security.
 *
 * @author Vladislav Brazovskij <u.brazouski@sam-solutions.com>
 * @package com.samsolutions.service.impl
 * @link http ://sam-solutions.com/
 * @copyright 2019 SaM
 */

@Service("UserDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

    private enum Roles implements GrantedAuthority{
        ROLE_USER,
        ROLE_PATIENT,
        ROLE_RECEPTIONIST,
        ROLE_ADMIN,
        ROLE_DOCTOR;

        public String getAuthority() {
            return name();
        }
    }

    @Autowired
    private UserService userService;

    @Autowired
    private UserConverter userConverter;

    @Override
    @Transactional(readOnly = true, propagation = Propagation.NESTED)
    public UserDetails loadUserByUsername(final String username) throws UsernameNotFoundException {
        UserDTO user = userConverter.entityToDTO(userService.findByUsername(username));

        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        for(GrantedAuthority a: Roles.values()) {
            for (RoleDTO role : user.getRoles()) {
                if (role.getName().equals(a.getAuthority()))
                    grantedAuthorities.add(new SimpleGrantedAuthority(role.getName()));
            }
        }

        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), grantedAuthorities);
    }
}