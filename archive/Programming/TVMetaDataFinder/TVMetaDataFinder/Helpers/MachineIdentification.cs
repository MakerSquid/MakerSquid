using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Management;
using System.Collections;
using System.Security.Cryptography;

public static class MachineIdentification
{

    public static string GetMachineID()
    {
        return CalculateMD5Hash(GetCPUInfo());
    }

    private static string CalculateMD5Hash(string input)
    {
        MD5 md5 = System.Security.Cryptography.MD5.Create();
        byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
        byte[] hash = md5.ComputeHash(inputBytes);

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < hash.Length; i++)
        {
            sb.Append(hash[i].ToString("X2"));
        }
        return sb.ToString();
    }


    private static string GetCPUInfo()
    {
        string returnString = string.Empty;
        //create instance of a hashtable to hold the info
        Hashtable cpuInfo = new Hashtable();
        //create an instance of the Managemnet class with the
        //Win32_Processor class
        ManagementClass mgmt = new ManagementClass("Win32_Processor");
        //create a ManagementObjectCollection to loop through
        ManagementObjectCollection objCol = mgmt.GetInstances();
        //start our loop for all processors found
        foreach (ManagementObject obj in objCol)
        {
            if (cpuInfo.Count == 0)
            {
                // only return cpuInfo from first CPU
                cpuInfo.Add("ProcessorID", obj.Properties["ProcessorId"].Value.ToString());
                cpuInfo.Add("DeviceID", obj.Properties["DeviceID"].Value.ToString());
                cpuInfo.Add("SocketDesignation", obj.Properties["SocketDesignation"].Value.ToString());
                cpuInfo.Add("Manufacturer", obj.Properties["Manufacturer"].Value.ToString());
            }
            //dispose of our object
            obj.Dispose();
        }
        //return to calling method

        string temp = string.Empty;
        foreach (string value in cpuInfo.Values)
        {
            temp += value;
        }
        return CalculateMD5Hash(temp);
    }
}