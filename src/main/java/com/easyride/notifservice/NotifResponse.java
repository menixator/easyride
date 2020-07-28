/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.easyride.notifservice;

import java.util.ArrayList;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author miljau_a
 */
@XmlRootElement (name="response")
public class NotifResponse {
    private ArrayList<String> errors = new ArrayList();
    private ArrayList<NotifModel> notifs = new ArrayList();

    public ArrayList<String> getErrors() {
        return errors;
    }

    public void setErrors(ArrayList<String> errors) {
        this.errors = errors;
    }

    public ArrayList<NotifModel> getNotifs() {
        return notifs;
    }

    public void setNotifs(ArrayList<NotifModel> notifs) {
        this.notifs = notifs;
    }
    
}
