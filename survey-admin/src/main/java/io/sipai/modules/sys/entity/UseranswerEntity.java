package io.sipai.modules.sys.entity;

import lombok.Data;


import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.List;
/**
 * 用户答题
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@Data
@TableName("useranswer")
public class UseranswerEntity implements Serializable {

	@TableId
	private Long id;
	/**
	 * 所选答案
	 */
	
	private Long usertestsId;
	
	private Long questionsId;
	
	private Long ansNumber;
	/**
	 * 答题时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private String ansTime;
	
	@TableField(exist=false)
	private String question;
	
	@TableField(exist=false)
	private String username;
	
	@TableField(exist=false)
	private String option1;
	@TableField(exist=false)
	private String option2;
	@TableField(exist=false)
	private String option3;
	@TableField(exist=false)
	private String option4;

}
