package com.samsolutions.converter;

import com.samsolutions.dto.data.UserDataDTO;
import com.samsolutions.dto.form.UserFormDTO;
import com.samsolutions.entity.User;
import com.samsolutions.service.RoleService;
import com.samsolutions.service.impl.UserServiceImpl;
import org.hibernate.LazyInitializationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Component
public class UserConverter implements DTOConverter<User, UserDataDTO, UserFormDTO> {

    private static final Logger logger = LoggerFactory.getLogger(UserConverter.class);

    @Autowired
    private RoleConverter roleConverter;

    @Autowired
    private RoleService roleService;

    @Override
    public UserDataDTO entityToDataDto(User source) {
        UserDataDTO target = new UserDataDTO();
        try {
            target.setId(source.getId());
        } catch (NullPointerException npe) {
            logger.debug("user don't exist");
            return target;
        }
        target.setUsername(source.getUsername());
        target.setPassword(source.getPassword());
        target.setName(source.getName());
        target.setSurname(source.getSurname());
        target.setPatronymic(source.getPatronymic());
        target.setTelephone(source.getTelephone());
        target.setBirth(Date.valueOf(source.getBirth()));
        target.setSex(source.getSex());
        target.setImg(source.getImg());
        try {
            target.setRoles(roleConverter.entitiesToDataDtoList(source.getRoles()));
            return target;
        } catch (LazyInitializationException le) {
            logger.debug(le.getMessage());
        }
        return target;
    }

    @Override
    public User formDtoToEntity(UserFormDTO source) {
        User target = new User();
        target.setId(source.getId());
        target.setUsername(source.getUsername());
        target.setPassword(source.getPassword());
        target.setName(source.getName());
        target.setSurname(source.getSurname());
        target.setPatronymic(source.getPatronymic());
        target.setTelephone(source.getTelephone());
        target.setSex(source.getSex());
        try {
            target.setRoles(roleService.findByIds(source.getRolesId()));
        } catch (NullPointerException ne) {
            logger.debug("DTO haven't roles");
        }
        try {
            target.setBirth(LocalDate.parse(source.getBirth(), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        } catch (NullPointerException ne) {
            logger.debug("DTO haven't birth");
        }
        return target;
    }

    @Override
    public List<UserDataDTO> entitiesToDataDtoList(List<User> sourceList) {
        List<UserDataDTO> targetList = new ArrayList<>();
        for (User source : sourceList) {
            UserDataDTO target = entityToDataDto(source);
            targetList.add(target);
        }
        return targetList;
    }
}
