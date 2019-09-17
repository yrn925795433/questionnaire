package io.sipai.modules.user.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

import java.io.Serializable;

/**
 * 答题管理
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2019-05-29 16:27:20
 */
@Data
@TableName("useranswer")
public class AnswersEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 答题ID
	 */
	@TableId(type=IdType.AUTO)
	private Long id;
	/**
	 * 测试ID
	 */
	private Long questionsId;
	
	private Long usertestsId;
	
	/**
	 * 题目ID
	 */
	private Long ansNumber;
	/**
	 * 答题时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private String ansTime;
	
	@TableField(exist = false)
	private Long testsId;
	
	@TableField(exist = false)
	private Long userId;
	
	

}
