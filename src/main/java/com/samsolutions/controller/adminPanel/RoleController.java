package com.samsolutions.controller.adminPanel;

import com.samsolutions.dto.data.RoleDataDTO;
import com.samsolutions.dto.form.RoleFormDTO;
import com.samsolutions.service.RoleService;
import com.samsolutions.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Controller of crud operations for table "role".
 *
 * @author Vladislav Brazovskij <u.brazouski@sam-solutions.com>
 * @package com.samsolutions.controller.adminPanel
 * @link http ://sam-solutions.com/
 * @copyright 2019 SaM
 */

@Controller
@RequestMapping("/adminpanel/role")
@Secured("ROLE_ADMIN")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserService userService;

    /**
     * Method to create a new role.
     *
     * @return redirects to main page of "role" crud.
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(Model model) {
        model.addAttribute("roleFormDTO", new RoleFormDTO());
        return "adminpanel/role/create";
    }

    /**
     * Method to shows records of "role" table.
     *
     * @param model is model.
     * @return return main page of "role" crud.
     */
    @RequestMapping(method = RequestMethod.GET)
    public String read(Model model) {
        model.addAttribute("DTOList", roleService.findAll());
        return "adminpanel/role/crud";
    }

    /**
     * Method to shows form for edit record of role table.
     *
     * @param model is model.
     * @param id    is id.
     * @return return main page of "role" crud.
     */
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") final Long id, final Model model) {
        RoleDataDTO roleDataDTO = roleService.findById(id);
        model.addAttribute("roleDataDTO", roleDataDTO);
        model.addAttribute("roleDTOForm", new RoleFormDTO());
        return "/adminpanel/role/edit";
    }

    @RequestMapping(value = "/details/{id}", method = RequestMethod.GET)
    public String details(@PathVariable("id") final Long id, Model model,
                          @RequestParam(value = "pageNo", required = false, defaultValue = "1") Integer pageNo,
                          @RequestParam(value = "pageSize", required = false, defaultValue = "15") Integer pageSize,
                          @RequestParam(value = "desc", required = false, defaultValue = "false") Boolean desc,
                          @RequestParam(value = "sort", required = false, defaultValue = "id") String sort) {
        model.mergeAttributes(userService.getMapAndPageByRole(id, pageNo, pageSize, desc, sort));
        model.addAttribute("roleDataDTO", roleService.findById(id));
        return "/adminpanel/role/details";
    }
}