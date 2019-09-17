package io.sipai.modules.sys.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 题目选择
 * 
 * @author leo
 * 
 */
@Data
@TableName("answers")
public class UserquestionEntity implements Serializable {
	/**
	 * 答题ID
	 */
	@TableId(type=IdType.AUTO)
	private Long id;
	
	private Long testsId;
	
	private Long questionsId;
	
	@TableField(exist=false)
	private String username;
	
	@TableField(exist=false)
	private String question;
	

}
