package com.samsolutions.controller.adminPanel;

import com.samsolutions.dto.data.ScheduleDataDTO;
import com.samsolutions.service.ScheduleService;
import com.samsolutions.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ScheduleRestController {

    @Autowired
    ScheduleService scheduleService;

    @Autowired
    TicketService ticketService;

    @GetMapping(value = "/adminpanel/schedule/{id}/{date}")
    @ResponseBody
    public List<ScheduleDataDTO> getSchedule(@PathVariable("id") Long id, @PathVariable("date") String date) {
        return scheduleService.getDayByDateAndId(date, id);
    }

    @GetMapping(value = "/adminpanel/schedule/booking/{patientId}/{scheduleId}")
    @ResponseBody
    public List<ScheduleDataDTO> bookTime(@PathVariable("patientId") Long patientId, @PathVariable("scheduleId") Long scheduleId) {
//        ticketService.booking(patientId,scheduleId);
        scheduleService.booking(patientId,scheduleId);
        return scheduleService.getDayBySchedule(scheduleId);
    }

    //todo: Чтобы забронироват талон нужно: сохранить талон в бд, и поместить id этого талона в расписание врача
}
