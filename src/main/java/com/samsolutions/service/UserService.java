package com.samsolutions.service;

import com.samsolutions.dto.data.UserDTO;
import com.samsolutions.dto.data.UserDataDTO;
import com.samsolutions.dto.form.UserFormDTO;
import com.samsolutions.entity.User;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * User service determine methods for working with user table.
 *
 * @author Vladislav Brazovskij <u.brazouski@sam-solutions.com>
 * @package com.samsolutions.service
 * @link http ://sam-solutions.com/
 * @copyright 2019 SaM
 */

@Service
public interface UserService {
    /**
     * Method for create user.
     *
     * @param userDTO UserDTO with parameters to be set.
     */
    void save(UserFormDTO formDTO);

    /**
     * Method for find user by id.
     *
     * @param id id of desired user.
     * @return UserDTO.
     */
    UserDataDTO findById(Long id);

    /**
     * Method for find user by username.
     *
     * @param username username of desired user.
     * @return UserDTO.
     */
    User findByUsername(String username);

    /**
     * Method for delete user by id.
     *
     * @param id id of desired user.
     */
    void delete(Long id);

    List<UserDataDTO> getPage(Integer pageNo, Integer pageSize, Boolean desc, String sort);

    UserDataDTO findWithRolesById(Long id);

    void deleteRoleFromUserById(Long userId, Long RoleId);

    Map<String,Object> getMapAndPageByRole(Long id, Integer pageNo, Integer pageSize, Boolean desc, String sort);

    Map<String, Object> getMapAndPage(Integer pageNo, Integer pageSize, Boolean desc, String sort);

    Set<UserDataDTO> findDoctors();

    List<UserDataDTO> findPatients(); //todo: why different types?
}