package io.sipai.modules.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.io.Serializable;

/**
 * 题库管理
 * @date 2019-05-29 16:27:20
 */
@Data
@TableName("questions")
public class QuestionsEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 题目ID
	 */
	@TableId(type = IdType.AUTO)
	private Long questionsId;
	/**
	 * 等级
	 */
	private String grade;
	/**
	 * 分类
	 */
	private String mainclass;
	/**
	 * 子域名称
	 */
	private String subclass;
	/**
	 * 子域权重
	 */
	private BigDecimal subweight;
	/**
	 * 题目名称
	 */
	private String question;
	/**
	 * 题目权重
	 */
	private BigDecimal quweight;
	/**
	 * 答案1
	 */
	private String option1;
	/**
	 * 答案2
	 */
	private String option2;
	/**
	 * 答案3
	 */
	private String option3;
	/**
	 * 答案4
	 */
	private String option4;

	private String enabled;
	
	
	@TableField(exist=false)
	private Boolean open;
	@TableField(exist=false)
	private List<?> list;

}
